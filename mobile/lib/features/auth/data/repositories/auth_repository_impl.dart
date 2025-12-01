// lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/token_data.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  // SYNC constructor
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResponse<TokenData>> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<ApiResponse<TokenData>> loginWithGoogle(String accessToken) async {
    return await remoteDataSource.loginWithGoogle(accessToken);
  }

  @override
  Future<ApiResponse<String>> register({
    required String code,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return await remoteDataSource.register(
      code: code,
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Future<ApiResponse<TokenData>> registerWithGoogle(String accessToken, String code) async {
    return await remoteDataSource.registerWithGoogle(accessToken, code);
  }

  /// Update password
  ///
  /// @param String currentPassword
  /// @param String newPassword
  /// @param String confirmPassword
  ///
  /// @return Future<ApiResponse<String>>
  @override
  Future<ApiResponse<String>> updatePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    return await remoteDataSource.updatePassword(
      currentPassword,
      newPassword,
      confirmPassword,
    );
  }
  
  /// Logout user
  ///
  /// @return Future<ApiResponse<String>>
  @override
  Future<ApiResponse<String>> logout() async {
    return await remoteDataSource.logout();
  }
}
