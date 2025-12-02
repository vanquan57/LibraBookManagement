import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/features/auth/domain/usecases/post_reset_password.dart';

@injectable
class ResetPasswordProvider extends ChangeNotifier {
  final PostResetPasswordUseCase resetPasswordUseCase;
  // SYNC constructor
  ResetPasswordProvider({required this.resetPasswordUseCase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isShowDialog = false;
  bool get isShowDialog => _isShowDialog;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  String? _message;
  String? get message => _message;

  /// The method reset password
  ///
  /// @param String token
  /// @param String email
  /// @param String newPassword
  /// @param String confirmPassword
  ///
  /// @return Future<bool>
  Future<void> resetPassword(
    String token,
    String email,
    String newPassword,
    String confirmPassword,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    _isShowDialog = false;
    notifyListeners();

    final response = await resetPasswordUseCase.call(
      token,
      email,
      newPassword,
      confirmPassword,
    );

    if (response.success) {
      _message = response.data ?? 'Đặt lại mật khẩu thành công';
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
    _isShowDialog = false;
    _errorMessage = null;
    _message = null;
    notifyListeners();
  }
}
