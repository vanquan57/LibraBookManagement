import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/features/auth/domain/usecases/get_verify_register_email.dart';

@injectable
class VerifyEmailRegisterProvider extends ChangeNotifier {
  final GetVerifyRegisterEmailUseCase getVerifyRegisterEmailUseCase;

  // SYNC constructor
  VerifyEmailRegisterProvider({
    required this.getVerifyRegisterEmailUseCase,
  });

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isShowDialog = false;
  bool get isShowDialog => _isShowDialog;

  String? _message;
  String? get message => _message;

  /// Verify email register
  ///
  /// @param VerifyRegisterEmailParams params
  ///
  /// @return Future<void>
  Future<void> verifyEmailRegister(VerifyRegisterEmailParams params) async {
    _isLoading = true;
    notifyListeners();
    
    final response = await getVerifyRegisterEmailUseCase(params);

    if (response.success) {
      _message = response.data ?? 'Email đã được xác thực thành công';
    } else {
      if (response.errors is Map) {
        _errorMessage = response.errors['error_message']?.toString();
      } else {
        _errorMessage = response.errors?.toString();
      }
    }

    _isShowDialog = true;
    _isLoading = false;
    notifyListeners();
  }

  void resetDialogState() {
    _errorMessage = null;
    _message = null;
    _isShowDialog = false;
    _isLoading = false;
    notifyListeners();
  }
}
