import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';

// UseCase base for feature login.
@lazySingleton
class GetVerifyRegisterEmailUseCase {
  final AuthRepository repository;

  // SYNC constructor
  GetVerifyRegisterEmailUseCase(this.repository);

  /// Call the use case
  ///
  /// @param VerifyRegisterEmailParams params
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> call(VerifyRegisterEmailParams params) async {
    return await repository.verifyEmailRegister(params);
  }
}

class VerifyRegisterEmailParams extends Equatable {
  final String id;
  final String hash;
  final String expires;
  final String signature;

  const VerifyRegisterEmailParams({
    required this.id,
    required this.hash,
    required this.expires,
    required this.signature,
  });

  @override
  List<Object?> get props => [id, hash, expires, signature];
}
