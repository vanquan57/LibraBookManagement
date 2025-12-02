import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

// UseCase base for feature login.
@lazySingleton
class PostVerifyEmailUseCase {
  final AuthRepository repository;

  // SYNC constructor
  PostVerifyEmailUseCase(this.repository);

  /// Call the use case
  ///
  /// @param String email
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> call(String email) async {
    return await repository.verifyEmail(email);
  }
}
