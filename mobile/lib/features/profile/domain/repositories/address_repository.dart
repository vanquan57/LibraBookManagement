import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/province/province.dart';
import 'package:mobile/share/data/models/district/district.dart';
import 'package:mobile/share/data/models/ward/ward.dart';

abstract class AddressRepository {
  /// Get list of provinces
  ///
  /// @return ApiResponse<List<Province>>
  Future<ApiResponse<List<Province>>> getProvinces();

  /// Get list of districts
  ///
  /// @param String provinceCode
  ///
  /// @return ApiResponse<List<District>>
  Future<ApiResponse<List<District>>> getDistricts(String provinceCode);

  /// Get list of wards
  ///
  /// @param String districtCode
  ///
  /// @return ApiResponse<List<Ward>>
  Future<ApiResponse<List<Ward>>> getWards(String districtCode);
}
