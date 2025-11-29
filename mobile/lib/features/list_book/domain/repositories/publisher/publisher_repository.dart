import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/publisher/publisher.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

abstract class PublisherRepository {
  /// Get list of publishers
  ///
  /// @param {number} limit - The limit number
  ///
  /// @return Future<ApiResponse<Paginated<Publisher>>> 
  Future<ApiResponse<Paginated<Publisher>>> getPublishers(int limit);
}
