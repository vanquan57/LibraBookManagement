import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/auth/data/models/token_data.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

class PostLoginGoogleUseCase {
  final AuthRepository repository;

  PostLoginGoogleUseCase({required this.repository});

  /// Call the use case
  ///
  /// @param String accessToken
  ///
  /// @return Future<ApiResponse<TokenData>>
  Future<ApiResponse<TokenData>> call(String accessToken) async {
    final response = await repository.loginWithGoogle(accessToken);

    return response;
  }
}
