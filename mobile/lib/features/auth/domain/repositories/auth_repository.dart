import 'package:mobile/core/response/api_response.dart';

import '../../data/models/token_data.dart';

abstract class AuthRepository {
  /// Login with email and password
  /// 
  /// @param String email
  /// @param String password
  ///
  /// @return Future<ApiResponse<TokenData>>
  Future<ApiResponse<TokenData>> login(String email, String password);

  /// Login with Google account
  ///
  /// @param String accessToken
  ///
  /// @return Future<ApiResponse<TokenData>>
  Future<ApiResponse<TokenData>> loginWithGoogle(String accessToken);
}
