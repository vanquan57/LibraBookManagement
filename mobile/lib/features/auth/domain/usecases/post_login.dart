import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/auth/data/models/token_data.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

// UseCase base for feature login.
@lazySingleton
class PostLoginUseCase {
  final AuthRepository repository;

  // SYNC constructor
  PostLoginUseCase(this.repository);

  /// Call the use case
  ///
  /// @param LoginParams params
  ///
  /// @return Future<ApiResponse<TokenData>>
  Future<ApiResponse<TokenData>> call(LoginParams params) async {
    final response = await repository.login(params.email, params.password);

    return response;
  }
}

// Class contain login parameters.
class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
