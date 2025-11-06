import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/auth/data/models/token_data.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

// UseCase base for feature login.
@lazySingleton
class PostRegisterUseCase {
  final AuthRepository repository;

  // SYNC constructor
  PostRegisterUseCase(this.repository);

  /// Call the use case
  ///
  /// @param RegisterParams params
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> call(RegisterParams params) async {
    final response = await repository.register(
      code: params.code,
      name: params.name,
      email: params.email,
      password: params.password,
      confirmPassword: params.confirmPassword,
    );

    return response;
  }
}

// Class contain register parameters.
class RegisterParams extends Equatable {
  final String code;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterParams({
    required this.code,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [code, name, email, password, confirmPassword];
}
