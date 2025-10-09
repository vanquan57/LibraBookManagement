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
}
