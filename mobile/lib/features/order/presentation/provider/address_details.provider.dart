import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/features/order/domain/usecase/address/get_districts.dart';
import 'package:mobile/features/order/domain/usecase/address/get_provinces.dart';
import 'package:mobile/features/order/domain/usecase/address/get_wards.dart';
import 'package:mobile/share/data/models/district/district.dart';
import 'package:mobile/share/data/models/province/province.dart';
import 'package:mobile/share/data/models/ward/ward.dart';

@injectable
class AddressDetailsProvider extends ChangeNotifier {
  final GetProvincesUseCase getProvincesUseCase;
  final GetDistrictsUseCase getDistrictsUseCase;
  final GetWardsUseCase getWardsUseCase;

  // SYNC constructor
  AddressDetailsProvider(
    this.getProvincesUseCase,
    this.getDistrictsUseCase,
    this.getWardsUseCase,
  );

  // List of provinces
  final List<Province> _provinces = [];
  List<Province> get provinces => List.unmodifiable(_provinces);

  // List of districts
  final List<District> _districts = [];
  List<District> get districts => List.unmodifiable(_districts);

  // List of wards
  final List<Ward> _wards = [];
  List<Ward> get wards => List.unmodifiable(_wards);

  /// Get list of provinces
  ///
  /// @return Future<void>
  Future<void> getProvinces() async {
    final response = await getProvincesUseCase();

    if (response.success && response.data != null) {
      _provinces.clear();
      _provinces.addAll(response.data!);
      notifyListeners();
    }
  }

  /// Get list of districts
  ///
  /// @param String provinceCode
  ///
  /// @return Future<void>
  Future<void> getDistricts(String provinceCode) async {
    final response = await getDistrictsUseCase(provinceCode);
    if (response.success && response.data != null) {
      _districts.clear();
      _districts.addAll(response.data!);
      notifyListeners();
    }
  }

  /// Get list of wards
  ///
  /// @param String districtCode
  ///
  /// @return Future<void>
  Future<void> getWards(String districtCode) async {
    final response = await getWardsUseCase(districtCode);
    if (response.success && response.data != null) {
      _wards.clear();
      _wards.addAll(response.data!);
      notifyListeners();
    }
  }

  /// Get full address string from IDs
  ///
  /// @param int provinceId
  /// @param int districtId
  /// @param int wardId
  /// @param String address
  ///
  /// @return Future<String>
  Future<String> getFullAddress({
    required int provinceId,
    required int districtId,
    required int wardId,
    required String address,
  }) async {
    String provinceName = '';
    String districtName = '';
    String wardName = '';

    try {
      // Get provinces if not loaded
      if (_provinces.isEmpty) {
        await getProvinces();
      }

      // Get province name and code
      final province = _provinces.firstWhere(
        (p) => p.id == provinceId,
      );
      provinceName = province.name;

      // Get districts using province code
      if (province.code != null) {
        await getDistricts(province.code!);
        
        final district = _districts.firstWhere(
          (d) => d.id == districtId,
        );
        districtName = district.name;

        // Get wards using district code
        if (district.code != null) {
          await getWards(district.code!);
          
          final ward = _wards.firstWhere(
            (w) => w.id == wardId,
          );
          wardName = ward.name;
        }
      }

      // Build full address string
      final addressParts = [
        address,
        wardName.isNotEmpty ? wardName : null,
        districtName.isNotEmpty ? districtName : null,
        provinceName.isNotEmpty ? provinceName : null,
      ].where((part) => part != null && part.isNotEmpty).join(', ');

      return addressParts.isNotEmpty ? addressParts : 'N/A';
    } catch (e) {
      debugPrint('Error getting full address: $e');
      return address.isNotEmpty ? address : 'N/A';
    }
  }
}