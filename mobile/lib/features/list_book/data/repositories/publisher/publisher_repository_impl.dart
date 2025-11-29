import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/list_book/data/datasources/publisher/publisher_remote_datasource.dart';
import 'package:mobile/features/list_book/domain/repositories/publisher/publisher_repository.dart';
import 'package:mobile/share/data/models/publisher/publisher.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@LazySingleton(as: PublisherRepository) 
class PublisherRepositoryImpl implements PublisherRepository {
  final PublisherRemoteDataSource remoteDataSource;

  // SYNC constructor
  PublisherRepositoryImpl(this.remoteDataSource);

  /// Get list of publishers
  ///
  /// @param {number} limit - The limit number
  ///
  /// @return Future<ApiResponse<Paginated<Publisher>>> 
  @override
  Future<ApiResponse<Paginated<Publisher>>> getPublishers(int limit) { 
    return remoteDataSource.getPublishers(limit: limit);
  }
}
