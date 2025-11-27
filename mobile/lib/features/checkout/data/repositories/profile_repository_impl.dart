import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/checkout/data/datasources/profile/profile_remote_datasource.dart';
import 'package:mobile/features/checkout/domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  // SYNC constructor
  ProfileRepositoryImpl(this.remoteDataSource);

  /// Get user profile
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  @override
  Future<ApiResponse<Map<String, dynamic>>> getInformationUser() async {
    return await remoteDataSource.getInformationUser();
  }
}
