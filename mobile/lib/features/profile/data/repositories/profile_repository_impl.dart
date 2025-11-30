import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/profile/data/datasources/profile/profile_remote_datasource.dart';
import 'package:mobile/features/profile/domain/repositories/profile_repository.dart';
import 'package:mobile/features/profile/domain/usecase/profile/update_profile.dart';
import 'package:mobile/share/data/models/user/user.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  // SYNC constructor
  ProfileRepositoryImpl(this.remoteDataSource);

  /// Get user profile
  ///
  /// @return ApiResponse<User>
  @override
  Future<ApiResponse<User>> getInformationUser() async {
    return await remoteDataSource.getInformationUser();
  }

  /// Update user profile
  ///
  /// @param UpdateProfileParam params
  ///
  /// @return ApiResponse<String>
  @override
  Future<ApiResponse<String>> updateProfile(UpdateProfileParam params) async {
    return await remoteDataSource.updateProfile(params);
  }
}
