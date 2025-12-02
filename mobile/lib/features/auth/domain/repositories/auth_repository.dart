import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/auth/domain/usecases/get_verify_register_email.dart';

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

  /// Update password
  ///
  /// @param String currentPassword
  /// @param String newPassword
  /// @param String confirmPassword
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> updatePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  );

  /// Logout user
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> logout();

  /// Verify email
  ///
  /// @param String email
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> verifyEmail(String email);

  /// Reset password
  ///
  /// @param String token
  /// @param String email
  /// @param String password
  /// @param String confirmPassword
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> resetPassword(String token, String email, String password, String confirmPassword);

  /// Verify email register
  ///
  /// @param VerifyRegisterEmailParams params
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> verifyEmailRegister(VerifyRegisterEmailParams params);
}
