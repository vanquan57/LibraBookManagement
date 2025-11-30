import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/features/auth/domain/usecases/update_password.dart';

@injectable
class ChangePasswordProvider extends ChangeNotifier {
  final UpdatePasswordUseCase updatePasswordUseCase;
  // SYNC constructor
  ChangePasswordProvider({required this.updatePasswordUseCase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isShowDialog = false;
  bool get isShowDialog => _isShowDialog;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  String? _message;
  String? get message => _message;

  /// The method update password
  ///
  /// @param String currentPassword
  /// @param String newPassword
  /// @param String confirmPassword
  ///
  /// @return Future<bool>
  Future<void> updatePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    _isShowDialog = false;
    notifyListeners();

    final response = await updatePasswordUseCase.call(
      currentPassword,
      newPassword,
      confirmPassword,
    );

    if (response.success) {
      _message = response.data ?? 'Cập nhật thông tin thành công';
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

  void resetErrorMessages() {
    _errorMessage = null;
    notifyListeners();
  }

  void resetDialogState() {
    _isShowDialog = false;
    _errorMessage = null;
    _message = null;
    notifyListeners();
  }
}
