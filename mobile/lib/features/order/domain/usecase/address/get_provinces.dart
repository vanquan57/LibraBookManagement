import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/order/domain/repositories/address_repository.dart';
import 'package:mobile/share/data/models/province/province.dart';

@lazySingleton
class GetProvincesUseCase {
  final AddressRepository repository;

  // SYNC constructor
  GetProvincesUseCase(this.repository);

  /// Get list of provinces
  ///
  /// @return ApiResponse<List<Province>>
  Future<ApiResponse<List<Province>>> call() async {
    return await repository.getProvinces();
  }
}
