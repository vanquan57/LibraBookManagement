import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/config/env.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/storage/local_storage_service.dart';
import 'package:mobile/features/auth/domain/usecases/post_login.dart';
import 'package:mobile/features/auth/data/models/token_data.dart';
import 'package:mobile/features/auth/domain/usecases/post_login_google.dart';

@injectable 
class LoginProvider extends ChangeNotifier {
  final PostLoginUseCase postLoginUseCase;
  final PostLoginGoogleUseCase postLoginGoogleUseCase;
  final LocalStorageService localStorageService;

  // SYNC constructor
  LoginProvider({
    required this.postLoginUseCase,
    required this.postLoginGoogleUseCase,
    required this.localStorageService,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isShowDialog = false;
  bool get isShowDialog => _isShowDialog;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  String? _errorMessageLoginGoogle;
  String? get errorMessageLoginGoogle => _errorMessageLoginGoogle;

  TokenData? _tokenData;
  TokenData? get tokenData => _tokenData;

  /// Login with email and password
  ///
  /// @param String email
  /// @param String password
  ///
  /// @return Future<bool>
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await postLoginUseCase(
      LoginParams(email: email, password: password),
    );

    if (response.success) {
      _tokenData = response.data;

      // Save token data to local storage
      await localStorageService.saveAccessToken(_tokenData!.accessToken);
      _isLoading = false;
      notifyListeners();

      return true;
    } else {
      if (response.errors is Map) {
        _errorMessage = response.errors['error_message']?.toString();
      } else {
        _errorMessage = response.errors?.toString();
      }
    }

    _isLoading = false;
    notifyListeners();

    return false;
  }

  /// Login with Google account
  ///
  /// @return Future<void>
  Future<void> loginGoogle() async {
    final googleSignIn = GoogleSignIn(
      clientId: Env.googleClientId,
      scopes: ['email', 'profile'],
    );

    await googleSignIn.signOut();

    final googleUser = await googleSignIn.signIn();
    
    if (googleUser == null) {
      debugPrint("Người dùng hủy đăng nhập Google");
      return;
    }

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;

    if (accessToken == null) {
      debugPrint("Google access token is null");
      return;
    }

    final response = await postLoginGoogleUseCase(accessToken);

    if (response.success) {
      _tokenData = response.data;

      // Save token data to local storage
      await localStorageService.saveAccessToken(_tokenData!.accessToken);
    } else {
      if (response.errors is Map) {
        _errorMessageLoginGoogle = response.errors['error_message']?.toString();
      } else {
        _errorMessageLoginGoogle = response.errors?.toString();
      }
      _isShowDialog = true;
    }

    notifyListeners();
  }

  void resetErrorMessages() {
    _errorMessage = null;
    notifyListeners();
  }
}
