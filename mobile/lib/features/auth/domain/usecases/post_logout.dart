import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

// UseCase base for feature login.
@lazySingleton
class PostLogoutUseCase {
  final AuthRepository repository;

  // SYNC constructor
  PostLogoutUseCase(this.repository);

  /// Call the use case
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> call() async {
    return await repository.logout();
  }
}
