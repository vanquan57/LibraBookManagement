import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/features/list_book/domain/usecase/author/get_list_author.dart';
import 'package:mobile/features/list_book/domain/usecase/book/get_books.dart';
import 'package:mobile/features/list_book/domain/usecase/category/get_list_category.dart';
import 'package:mobile/features/list_book/domain/usecase/publisher/get_list_publisher.dart';
import 'package:mobile/share/data/models/author/author.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/category/category.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';
import 'package:mobile/share/data/models/publisher/publisher.dart';

@injectable
class ListBookProvider extends ChangeNotifier {
  final GetBooksUseCase getBooksUseCase;
  final GetListCategoriesUseCase getListCategoriesUseCase;
  final GetListPublisherUseCase getListPublisherUseCase;
  final GetListAuthorsUseCase getListAuthorsUseCase;

  // SYNC constructor
  ListBookProvider({
    required this.getBooksUseCase,
    required this.getListCategoriesUseCase,
    required this.getListPublisherUseCase,
    required this.getListAuthorsUseCase,
  });

  // Sidebar state
  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  // Categories state
  Paginated<Category>? _categories;
  Paginated<Category>? get categories => _categories;
  bool _isLoadingCategories = false;

  // Authors state
  Paginated<Author>? _authors;
  Paginated<Author>? get authors => _authors;
  bool _isLoadingAuthors = false;

  // Publishers state
  Paginated<Publisher>? _publishers;
  Paginated<Publisher>? get publishers => _publishers;
  bool _isLoadingPublishers = false;

  // Books state
  Paginated<Book>? _books;
  Paginated<Book>? get books => _books;
  bool _isLoadingBooks = false;
  bool get isLoadingBooks => _isLoadingBooks;
  int _currentPageBooks = 1;
  int get currentPageBooks => _currentPageBooks;
  String? _nextPageUrlBooks;
  String? get nextPageUrlBooks => _nextPageUrlBooks;
  int? _lastPageBooks;
  int? get lastPageBooks => _lastPageBooks;

  /// Initialize data - load categories, authors, publishers, books
  ///
  /// @return Future<void>
  Future<void> initializeData() async {
    await Future.wait([
      getCategories(),
      getAuthors(),
      getPublishers(),
    ]);
  }

  /// Get list of categories (all data at once)
  ///
  /// @return Future<void>
  Future<void> getCategories() async {
    if (_isLoadingCategories) return;
    _isLoadingCategories = true;

    final response = await getListCategoriesUseCase(AppConstants.LIMIT_INFINITY);

    if (response.data != null) {
      _categories = response.data;
      notifyListeners();
    }

    _isLoadingCategories = false;
  }

  /// Get list of authors (all data at once)
  ///
  /// @return Future<void>
  Future<void> getAuthors() async {
    if (_isLoadingAuthors) return;
    _isLoadingAuthors = true;

    final response = await getListAuthorsUseCase(AppConstants.LIMIT_INFINITY);

    if (response.data != null) {
      _authors = response.data;
      notifyListeners();
    }

    _isLoadingAuthors = false;
  }

  /// Get list of publishers (all data at once)
  ///
  /// @return Future<void>
  Future<void> getPublishers() async {
    if (_isLoadingPublishers) return;
    _isLoadingPublishers = true;

    final response = await getListPublisherUseCase(AppConstants.LIMIT_INFINITY);

    if (response.data != null) {
      _publishers = response.data;
      notifyListeners();
    }

    _isLoadingPublishers = false;
  }

  /// Toggle sidebar visibility
  ///
  /// @return void
  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners();
  }

  /// Open sidebar
  ///
  /// @return void
  void openSidebar() {
    _isSidebarOpen = true;
    notifyListeners();
  }

  /// Close sidebar
  ///
  /// @return void
  void closeSidebar() {
    _isSidebarOpen = false;
    notifyListeners();
  }

  /// Get books with filters
  ///
  /// @param {int} page - The page number
  /// @param {bool} append - Whether to append results
  /// @param {String?} searchQuery - Search query
  /// @param {int?} categoryId - Category ID
  /// @param {List<int>?} authorIds - Author IDs
  /// @param {List<int>?} publisherIds - Publisher IDs
  /// @param {int?} mostBorrowed - Most borrowed filter
  /// @param {int?} mostViewed - Most viewed filter
  /// @param {int?} mostLoved - Most loved filter
  ///
  /// @return Future<void>
  Future<void> getBooks({
    required int page,
    bool append = false,
    String? searchQuery,
    int? categoryId,
    List<int>? authorIds,
    List<int>? publisherIds,
    int? mostBorrowed,
    int? mostViewed,
    int? mostLoved,
  }) async {
    if (_isLoadingBooks) return;
    _isLoadingBooks = true;
    notifyListeners();

    final params = BookParams(
      page: page,
      limit: AppConstants.LIMIT_BOOK,
      name: searchQuery,
      categoryId: categoryId,
      authorIds: authorIds,
      publisherIds: publisherIds,
      mostBorrowed: mostBorrowed,
      mostViewed: mostViewed,
      mostLoved: mostLoved,
      order: AppConstants.DEFAULT_ORDER,
    );

    final response = await getBooksUseCase(params);

    if (response.data != null) {
      if (append && _books != null) {
        _books!.data.addAll(response.data!.data);
      } else {
        _books = response.data;
      }

      _currentPageBooks = page;
      _nextPageUrlBooks = response.data!.nextPageUrl;
      _lastPageBooks = response.data!.lastPage;
    } else {
      if (!append) {
        _books = null;
      }
    }

    _isLoadingBooks = false;
    notifyListeners();
  }

}
