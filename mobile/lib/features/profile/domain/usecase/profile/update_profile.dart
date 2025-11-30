import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/profile/domain/repositories/profile_repository.dart';

@lazySingleton
class UpdateProfileUseCase {
  final ProfileRepository repository;

  // SYNC constructor
  UpdateProfileUseCase(this.repository);

  /// Update user profile
  ///
  /// @param UpdateProfileParam params
  ///
  /// @return ApiResponse<String>
  Future<ApiResponse<String>> call(UpdateProfileParam params) async {
    return await repository.updateProfile(params);
  }
}

class UpdateProfileParam {
  final String name;
  final String address;
  final int provinceId;
  final int districtId;
  final int wardId;

  UpdateProfileParam({
    required this.name,
    required this.address,
    required this.provinceId,
    required this.districtId,
    required this.wardId,
  });

  @override
  List<Object?> get props => [name, provinceId, districtId, wardId, address];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'province_id': provinceId,
      'district_id': districtId,
      'ward_id': wardId,
      'address': address,
    };
  }
}
