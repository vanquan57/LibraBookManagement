import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/auth/data/models/token_data.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class PostRegisterGoogleUseCase {
  final AuthRepository repository;

  // SYNC constructor
  PostRegisterGoogleUseCase(this.repository);

  /// Call the use case
  ///
  /// @param String accessToken
  ///
  /// @return Future<ApiResponse<TokenData>>
  Future<ApiResponse<TokenData>> call(String accessToken, String code) async {
    return await repository.registerWithGoogle(accessToken, code);
  }
}
