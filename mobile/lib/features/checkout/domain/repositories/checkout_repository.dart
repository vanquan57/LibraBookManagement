
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/checkout/domain/usecase/checkout/submit_checkout.dart';

abstract class CheckoutRepository { 
  /// Submit form borrow books
  ///
  /// @param CheckoutParam params
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> submit(CheckoutParam params);
}
