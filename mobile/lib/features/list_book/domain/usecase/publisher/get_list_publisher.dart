import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/list_book/domain/repositories/publisher/publisher_repository.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';
import 'package:mobile/share/data/models/publisher/publisher.dart';

@lazySingleton
class GetListPublisherUseCase {
  final PublisherRepository repository;

  // SYNC constructor
  GetListPublisherUseCase(this.repository);
  
  /// Get list of publishers
  ///
  /// @param {number} limit - The limit number
  ///
  /// @return Future<ApiResponse<Paginated<Publisher>>> 
  Future<ApiResponse<Paginated<Publisher>>> call(int limit) async {
    return await repository.getPublishers(limit);
  }
}
