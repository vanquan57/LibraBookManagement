import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/profile/domain/usecase/profile/update_profile.dart';
import 'package:mobile/share/data/models/user/user.dart';

abstract class ProfileRepository {
  /// Get user profile
  ///
  /// @return ApiResponse<User>
  Future<ApiResponse<User>> getInformationUser();

  /// Update user profile
  ///
  /// @param UpdateProfileParam params
  ///
  /// @return ApiResponse<String>
  Future<ApiResponse<String>> updateProfile(UpdateProfileParam params);
}
