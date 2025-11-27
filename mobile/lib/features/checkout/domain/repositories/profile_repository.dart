import 'package:mobile/core/response/api_response.dart';

abstract class ProfileRepository { 
  /// Get user profile
  ///
  /// @return ApiResponse<Map<String, dynamic>> 
  Future<ApiResponse<Map<String, dynamic>>> getInformationUser();
}
