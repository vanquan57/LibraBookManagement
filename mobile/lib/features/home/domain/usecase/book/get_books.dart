import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';
import 'package:mobile/features/home/domain/repositories/book/book_repository.dart';

@lazySingleton
class GetBooksUseCase {
  final BookRepository repository;

  // SYNC constructor
  GetBooksUseCase(this.repository);

  /// Get books
  ///
  /// @param BookParams params
  ///
  /// @return Future<ApiResponse<Paginated<Book>>>
  Future<ApiResponse<Paginated<Book>>> call(BookParams params) async {
    return await repository.getBooks(params);
  }
}

// Class contain book parameters.
class BookParams extends Equatable {
  final int page;
  final int? limit;
  final int? mostBorrowed;
  final int? mostViewed;
  final int? latest;
  final String? order;

  const BookParams({
    required this.page,
    this.limit,
    this.mostBorrowed,
    this.mostViewed,
    this.latest,
    this.order,
  });

  @override
  List<Object?> get props => [page, limit, mostBorrowed, mostViewed, latest, order];
}
