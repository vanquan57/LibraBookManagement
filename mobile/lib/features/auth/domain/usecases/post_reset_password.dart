import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class PostResetPasswordUseCase { 
  final AuthRepository repository;

  // SYNC constructor
  PostResetPasswordUseCase(this.repository);

  /// Call the use case to reset password
  ///
  /// @param String token
  /// @param String email
  /// @param String newPassword
  /// @param String confirmPassword
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> call(
      String token,
      String email,
      String password,
      String confirmPassword,
  ) async {
    return await repository.resetPassword(token, email, password, confirmPassword);
  }
}
