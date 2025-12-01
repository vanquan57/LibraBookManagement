import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/order/domain/repositories/address_repository.dart';
import 'package:mobile/features/order/data/datasources/province/province_remote_datasource.dart';
import 'package:mobile/features/order/data/datasources/district/district_remote_datasource.dart';
import 'package:mobile/features/order/data/datasources/ward/ward_remote_datasource.dart';
import 'package:mobile/share/data/models/district/district.dart';
import 'package:mobile/share/data/models/province/province.dart';
import 'package:mobile/share/data/models/ward/ward.dart';

@LazySingleton(as: AddressRepository)
class AddressRepositoryImpl implements AddressRepository {
  final ProvinceRemoteDataSource provinceRemoteDataSource;
  final DistrictRemoteDataSource districtRemoteDataSource;
  final WardRemoteDataSource wardRemoteDataSource;

  // SYNC constructor
  AddressRepositoryImpl(
    this.provinceRemoteDataSource,
    this.districtRemoteDataSource,
    this.wardRemoteDataSource,
  );

  /// Get list of provinces
  ///
  /// @return ApiResponse<List<Province>>
  @override
  Future<ApiResponse<List<Province>>> getProvinces() {
    return provinceRemoteDataSource.getProvinces();
  }

  /// Get list of districts
  ///
  /// @param String provinceCode
  ///
  /// @return ApiResponse<List<District>>
  @override
  Future<ApiResponse<List<District>>> getDistricts(String provinceCode) {
    return districtRemoteDataSource.getDistricts(provinceCode);
  }

  /// Get list of wards
  ///
  /// @param String districtCode
  ///
  /// @return ApiResponse<List<Ward>>
  @override
  Future<ApiResponse<List<Ward>>> getWards(String districtCode) {
    return wardRemoteDataSource.getWards(districtCode);
  }
}
