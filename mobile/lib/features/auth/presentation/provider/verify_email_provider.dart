import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/features/auth/domain/usecases/post_verify_email.dart';

@injectable
class VerifyEmailProvider extends ChangeNotifier {
  final PostVerifyEmailUseCase postVerifyEmailUseCase;

  // SYNC constructor
  VerifyEmailProvider({
    required this.postVerifyEmailUseCase,
  });

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isShowDialog = false;
  bool get isShowDialog => _isShowDialog;

  String? _message;
  String? get message => _message;

  /// Verify email
  ///
  /// @param String email
  ///
  /// @return Future<void>
  Future<void> verifyEmail(String email) async {
    final response = await postVerifyEmailUseCase(email);

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
