import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/features/profile/domain/usecase/address/get_districts.dart';
import 'package:mobile/features/profile/domain/usecase/address/get_provinces.dart';
import 'package:mobile/features/profile/domain/usecase/address/get_wards.dart';
import 'package:mobile/features/profile/domain/usecase/profile/get_profile.dart';
import 'package:mobile/features/profile/domain/usecase/profile/update_profile.dart';
import 'package:mobile/share/data/models/district/district.dart';
import 'package:mobile/share/data/models/province/province.dart';
import 'package:mobile/share/data/models/user/user.dart';
import 'package:mobile/share/data/models/ward/ward.dart';

@injectable
class ProfileProvider extends ChangeNotifier {
  final GetProvincesUseCase getProvincesUseCase;
  final GetDistrictsUseCase getDistrictsUseCase;
  final GetWardsUseCase getWardsUseCase;
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  // SYNC constructor
  ProfileProvider(
    this.getProvincesUseCase,
    this.getDistrictsUseCase,
    this.getWardsUseCase,
    this.getProfileUseCase,
    this.updateProfileUseCase,
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

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isShowDialog = false;
  bool get isShowDialog => _isShowDialog;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _message;
  String? get message => _message;

  // User information
  User? _userInformation;
  User? get userInformation => _userInformation;

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
  /// @return Future<void>
  Future<void> getWards(String districtCode) async {
    final response = await getWardsUseCase(districtCode);
    if (response.success && response.data != null) {
      _wards.clear();
      _wards.addAll(response.data!);
      notifyListeners();
    }
  }

  /// Get user profile information
  ///
  /// @return Future<void>
  Future<void> getInformationUser() async {
    _isLoading = true;
    _errorMessage = null;
    _isShowDialog = false;
    notifyListeners();

    final response = await getProfileUseCase();

    if (response.success && response.data != null) {
      _userInformation = response.data!;
      notifyListeners();
    } else {
      if (response.errors is Map) {
        _errorMessage = response.errors['error_message']?.toString();
      } else {
        _errorMessage = response.errors?.toString();
      }
    }

    _isShowDialog = true;
    _isLoading = false;
    notifyListeners();
  }

  /// Update profile
  ///
  /// @param Map<String, dynamic> params
  ///
  /// @return Future<void>
  Future<void> updateProfile(Map<String, dynamic> params) async {
    _isLoading = true;
    _errorMessage = null;
    _isShowDialog = false;
    notifyListeners();

    final response = await updateProfileUseCase.call(
      UpdateProfileParam(
        name: params['name'],
        address: params['address'],
        provinceId: params['province_id'],
        districtId: params['district_id'],
        wardId: params['ward_id'],
      ),
    );

    if (response.success) {
      _message = response.data ?? 'Cập nhật thông tin thành công';
    } else {
      if (response.errors is Map) {
        _errorMessage = response.errors['error_message']?.toString();
      } else {
        _errorMessage = response.errors?.toString();
      }
    }

    _isShowDialog = true;
    _isLoading = false;
    notifyListeners();
  }

  /// Reset dialog state
  /// 
  /// @return void
  void resetDialogState() {
    _isShowDialog = false;
    _message = null;
    _errorMessage = null;
    notifyListeners();
  }
}
