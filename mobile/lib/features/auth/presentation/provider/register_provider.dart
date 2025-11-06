import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/storage/local_storage_service.dart';
import 'package:mobile/features/auth/data/models/token_data.dart';
import 'package:mobile/features/auth/domain/usecases/post_register.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/core/config/env.dart';
import 'package:mobile/features/auth/domain/usecases/post_register_google.dart';

@injectable
class RegisterProvider extends ChangeNotifier {
  final PostRegisterUseCase postRegisterUseCase;
  final PostRegisterGoogleUseCase postRegisterGoogleUseCase;
  final LocalStorageService localStorageService;

  // SYNC constructor
  RegisterProvider({
    required this.postRegisterUseCase,
    required this.postRegisterGoogleUseCase,
    required this.localStorageService,
  });

  bool _isLoading = false;
  String? _message;
  bool get isLoading => _isLoading;
  String? get message => _message;
  TokenData? _tokenData;
  TokenData? get tokenData => _tokenData;
  String? _errorMessageRegisterGoogle;
  String? get errorMessageRegisterGoogle => _errorMessageRegisterGoogle;
  bool _isShowDialog = false;
  bool get isShowDialog => _isShowDialog;

  /// Register with code, name, email, password, confirmPassword
  ///
  /// @param String code
  /// @param String email
  /// @param String name
  /// @param String password
  /// @param String confirmPassword
  ///
  /// @return Future<bool>
  Future<bool> register({
    required String code,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    final response = await postRegisterUseCase(
      RegisterParams(
        code: code,
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      ),
    );

    _isLoading = false;

    if (response.success) {
      _message = response.data ?? response.data ?? "Đăng ký thành công!";
      notifyListeners();

      return true;
    } else {
      if (response.errors is Map && response.errors['error_message'] != null) {
        _message = response.errors['error_message'].toString();
      } else {
        _message = response.errors?.toString() ?? "Đăng ký thất bại.";
      }

      notifyListeners();

      return false;
    }
  }

  /// Register with Google account
  ///
  /// @param String code
  ///
  /// @return Future<void>
  Future<void> registerGoogle(String code) async {
    final googleSignIn = GoogleSignIn(
      clientId: Env.googleClientId,
      scopes: ['email', 'profile'],
    );

    await googleSignIn.signOut();

    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      debugPrint("Người dùng hủy đăng ký Google");
      
      return;
    }

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;

    if (accessToken == null) {
      debugPrint(
        "Có lỗi xảy ra trong quá trình đăng ký Google: access token là null",
      );
      return;
    }

    final response = await postRegisterGoogleUseCase(accessToken, code);

    if (response.success) {
      _tokenData = response.data;

      // Save token data to local storage
      await localStorageService.saveAccessToken(_tokenData!.accessToken);
    } else {
      if (response.errors is Map) {
        _errorMessageRegisterGoogle = response.errors['error_message']
            ?.toString();
      } else {
        _errorMessageRegisterGoogle = response.errors?.toString();
      }

      _isShowDialog = true;
    }

    notifyListeners();
  }

  void resetDialogState() {
    _isShowDialog = false;
    _errorMessageRegisterGoogle = null;
    notifyListeners();
  }
}
