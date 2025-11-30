import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/profile/domain/repositories/profile_repository.dart';
import 'package:mobile/share/data/models/user/user.dart';

@lazySingleton
class GetProfileUseCase {
  final ProfileRepository repository;

  // SYNC constructor
  GetProfileUseCase(this.repository);

  /// Get user profile
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<User>> call() async {
    return await repository.getInformationUser();
  }
}
