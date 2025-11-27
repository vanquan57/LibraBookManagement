import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/checkout/domain/repositories/address_repository.dart';
import 'package:mobile/share/data/models/district/district.dart';

@lazySingleton
class GetDistrictsUseCase {
  final AddressRepository repository;

  // SYNC constructor
  GetDistrictsUseCase(this.repository);

  /// Get list of districts
  ///
  /// @param String provinceCode
  ///
  /// @return ApiResponse<List<District>>
  Future<ApiResponse<List<District>>> call(String provinceCode) async {
    return await repository.getDistricts(provinceCode);
  }
}
