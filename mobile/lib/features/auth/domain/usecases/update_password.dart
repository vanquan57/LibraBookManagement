import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class UpdatePasswordUseCase {
  final AuthRepository repository;

  // SYNC constructor
  UpdatePasswordUseCase(this.repository);

  /// Call the use case to update password
  ///
  /// @param String currentPassword
  /// @param String newPassword
  /// @param String confirmPassword
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> call(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    return await repository.updatePassword(currentPassword, newPassword, confirmPassword);
  }
}
