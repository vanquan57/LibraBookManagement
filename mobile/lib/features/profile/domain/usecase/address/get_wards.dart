import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/profile/domain/repositories/address_repository.dart';
import 'package:mobile/share/data/models/ward/ward.dart';

@lazySingleton
class GetWardsUseCase {
  final AddressRepository repository;

  // SYNC constructor
  GetWardsUseCase(this.repository);

  /// Get list of wards
  ///
  /// @param String districtCode
  ///
  /// @return ApiResponse<List<Ward>>
  Future<ApiResponse<List<Ward>>> call(String districtCode) async {
    return await repository.getWards(districtCode);
  }
}
