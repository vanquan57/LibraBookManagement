import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/auth/data/models/token_data.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class PostLoginGoogleUseCase {
  final AuthRepository repository;

  // SYNC constructor
  PostLoginGoogleUseCase(this.repository);

  /// Call the use case
  ///
  /// @param String accessToken
  ///
  /// @return Future<ApiResponse<TokenData>>
  Future<ApiResponse<TokenData>> call(String accessToken) async {
    return await repository.loginWithGoogle(accessToken);
  }
}
