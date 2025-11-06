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

  /// Register with name, code, email, password and confirm password
  ///   
  /// @param String name
  /// @param String code
  /// @param String email
  /// @param String password
  /// @param String confirmPassword
  /// 
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> register({
    required String code,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

  /// Register with Google account
  ///
  /// @param String accessToken
  ///
  /// @return Future<ApiResponse<TokenData>>
  Future<ApiResponse<TokenData>> registerWithGoogle(String accessToken, String code);
}
