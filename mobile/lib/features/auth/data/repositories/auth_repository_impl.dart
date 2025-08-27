import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/token_data.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  /// Login with email and password
  /// 
  /// @param String email
  /// @param String password
  ///
  /// @return Future<ApiResponse<TokenData>>
  @override
  Future<ApiResponse<TokenData>> login(String email, String password) async {
    final apiResponse = await remoteDataSource.login(email, password);

    return apiResponse;
  }

  /// Login with Google account
  /// 
  /// @param String accessToken
  ///
  /// @return Future<ApiResponse<TokenData>>
  @override
  Future<ApiResponse<TokenData>> loginWithGoogle(String accessToken) async {
    final apiResponse = await remoteDataSource.loginWithGoogle(accessToken);

    return apiResponse;
  }
}
