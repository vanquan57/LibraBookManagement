import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/checkout/domain/repositories/checkout_repository.dart';

@lazySingleton
class SubmitCheckoutUseCase {
  final CheckoutRepository repository;

  // SYNC constructor
  SubmitCheckoutUseCase(this.repository);
  
  /// Submit form borrow books
  ///
  /// @param CheckoutParam params
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> call(CheckoutParam params) async { 
    return await repository.submit(params);  
  }
}

  // Class contain checkout request parameters that map to the frontend form
  class CheckoutParam extends Equatable {
    final String name;
    final String email;
    final String phone;
    final int provinceId;
    final int districtId;
    final int wardId;
    final String address;
    final List<Map<String, dynamic>> orderDetails;

    const CheckoutParam({
      required this.name,
      required this.email,
      required this.phone,
      required this.provinceId,
      required this.districtId,
      required this.wardId,
      required this.address,
      required this.orderDetails,
    });

    @override
    List<Object?> get props => [
          name,
          email,
          phone,
          provinceId,
          districtId,
          wardId,
          address,
          orderDetails,
        ];

    Map<String, dynamic> toJson() {
      return {
        'name': name,
        'email': email,
        'phone': phone,
        'province_id': provinceId,
        'district_id': districtId,
        'ward_id': wardId,
        'address': address,
        'order_details': orderDetails,
      };
    }
  }
