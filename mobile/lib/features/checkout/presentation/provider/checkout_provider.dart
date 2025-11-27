import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/features/checkout/domain/usecase/address/get_districts.dart';
import 'package:mobile/features/checkout/domain/usecase/address/get_provinces.dart';
import 'package:mobile/features/checkout/domain/usecase/address/get_wards.dart';
import 'package:mobile/features/checkout/domain/usecase/checkout/submit_checkout.dart';
import 'package:mobile/features/checkout/domain/usecase/profile/profile_checkout.dart';
import 'package:mobile/share/data/models/district/district.dart';
import 'package:mobile/share/data/models/province/province.dart';
import 'package:mobile/share/data/models/ward/ward.dart';

@injectable
class CheckoutProvider extends ChangeNotifier {
  final GetProvincesUseCase getProvincesUseCase;
  final GetDistrictsUseCase getDistrictsUseCase;
  final GetWardsUseCase getWardsUseCase;
  final ProfileCheckoutUseCase profileCheckoutUseCase;
  final SubmitCheckoutUseCase submitCheckoutUseCase;

  // SYNC constructor
  CheckoutProvider(
    this.getProvincesUseCase,
    this.getDistrictsUseCase,
    this.getWardsUseCase,
    this.profileCheckoutUseCase,
    this.submitCheckoutUseCase,
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

  // User profile data
  Map<String, dynamic>? _userProfile;
  Map<String, dynamic>? get userProfile => _userProfile;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isShowDialog = false;
  bool get isShowDialog => _isShowDialog;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _message;
  String? get message => _message;

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
    final response = await profileCheckoutUseCase();

    if (response.success && response.data != null) {
      _userProfile = response.data;
      notifyListeners();
    }
  }

  /// Submit form borrow books
  ///
  /// @param CheckoutParam params
  ///
  /// @return Future<void>
  Future<void> submit(Map<String, dynamic> params) async {
    _isLoading = true;
    _errorMessage = null;
    _isShowDialog = false;
    notifyListeners();

    final response = await submitCheckoutUseCase.call(
      CheckoutParam(
        name: params['name'],
        email: params['email'],
        phone: params['phone'],
        provinceId: params['province_id'],
        districtId: params['district_id'],
        wardId: params['ward_id'],
        address: params['address'],
        orderDetails: params['orderDetails'],
      ),
    );

    if (response.success) {
      _message = response.data?['message']?.toString();
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
