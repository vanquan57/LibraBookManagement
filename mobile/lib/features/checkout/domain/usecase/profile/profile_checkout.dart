import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/checkout/domain/repositories/profile_repository.dart';

@lazySingleton
class ProfileCheckoutUseCase {
  final ProfileRepository repository;

  // SYNC constructor
  ProfileCheckoutUseCase(this.repository);
  
  /// Get user profile
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> call() async { 
    return await repository.getInformationUser();  
  }
}
