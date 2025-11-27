import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/checkout/data/datasources/checkout/checkout_remote_datasource.dart';
import 'package:mobile/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:mobile/features/checkout/domain/usecase/checkout/submit_checkout.dart';

@LazySingleton(as: CheckoutRepository)
class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource remoteDataSource;

  // SYNC constructor
  CheckoutRepositoryImpl(this.remoteDataSource);

  /// Submit form borrow books
  ///
  /// @param CheckoutParam params
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  @override
  Future<ApiResponse<Map<String, dynamic>>> submit(CheckoutParam params) {
    return remoteDataSource.submit(params);
  }
}
