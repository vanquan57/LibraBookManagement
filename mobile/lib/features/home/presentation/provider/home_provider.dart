import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/features/home/domain/usecase/book/get_books.dart';
import 'package:mobile/features/home/domain/usecase/category/get_list_category.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/category/category.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@injectable
class HomeProvider extends ChangeNotifier {
  final GetBooksUseCase getBooksUseCase;
  final GetListCategoriesUseCase getListCategoriesUseCase;

  // SYNC constructor
  HomeProvider({
    required this.getBooksUseCase,
    required this.getListCategoriesUseCase,
  });

  /// Top borrowed books state
  Paginated<Book>? _topBorrowedBooks;
  Paginated<Book>? get topBorrowedBooks => _topBorrowedBooks;
  bool _isLoadingMoreTopBorrowedBooks = false;
  int _currentPageTopBorrowedBooks = 1;
  String? _nextPageUrlTopBorrowedBooks;
  int? _lastPageTopBorrowedBooks;

  // List of categories state
  Paginated<Category>? _categories;
  Paginated<Category>? get categories => _categories;
  bool _isLoadingMoreCategories = false;
  int _currentPageCategories = 1;
  String? _nextPageUrlCategories;
  int? _lastPageCategories;

  /// List of most viewed books state
  Paginated<Book>? _mostViewedBooks;
  Paginated<Book>? get mostViewedBooks => _mostViewedBooks;
  bool _isLoadingMoreMostViewedBooks = false;
  int _currentPageMostViewedBooks = 1;
  String? _nextPageUrlMostViewedBooks;
  int? _lastPageMostViewedBooks;

  /// List of most new released
  Paginated<Book>? _newReleasedBooks;
  Paginated<Book>? get newReleasedBooks => _newReleasedBooks;
  bool _isLoadingMoreNewReleasedBooks = false;
  int _currentPageNewReleasedBooks = 1;
  String? _nextPageUrlNewReleasedBooks;
  int? _lastPageNewReleasedBooks;

  /// Get top books most borrowed
  ///
  /// @param {number} page - The page number
  /// @param {boolean} append - Whether to append the results or replace
  ///
  /// @return Future<void>
  Future<void> getTopBorrowedBooks(int page, {bool append = false}) async {
    if (_isLoadingMoreTopBorrowedBooks) return;
    _isLoadingMoreTopBorrowedBooks = true;

    final response = await getBooksUseCase(
      BookParams(
        page: page,
        limit: AppConstants.LIMIT_BOOK,
        mostBorrowed: AppConstants.TRUE,
        order: AppConstants.DEFAULT_ORDER,
      ),
    );

    if (response.data != null) {
      if (append && _topBorrowedBooks != null) {
        _topBorrowedBooks!.data.addAll(response.data!.data);
      } else {
        _topBorrowedBooks = response.data;
      }

      _currentPageTopBorrowedBooks = page;
      _nextPageUrlTopBorrowedBooks = response.data!.nextPageUrl;
      _lastPageTopBorrowedBooks = response.data!.lastPage;

      notifyListeners();
    }

    _isLoadingMoreTopBorrowedBooks = false;
  }

  /// Load next page of top borrowed books
  ///
  /// @return {Future<void>}
  Future<void> loadNextPageTopBorrowedBooks() async {
    if (_nextPageUrlTopBorrowedBooks == null) {
      return;
    }

    if (_currentPageTopBorrowedBooks >=
        (_lastPageTopBorrowedBooks ?? _currentPageTopBorrowedBooks)) {
      return;
    }

    await getTopBorrowedBooks(_currentPageTopBorrowedBooks + 1, append: true);
  }

  /// Get list of categories
  ///
  /// @param {number} page - The page number
  /// @param {boolean} append - Whether to append the results or replace
  ///
  /// @return Future<void>
  Future<void> getListCategories(int page, {bool append = false}) async {
    if (_isLoadingMoreCategories) return;
    _isLoadingMoreCategories = true;

    final response = await getListCategoriesUseCase(page);

    if (response.data != null) {
      if (append && _categories != null) {
        _categories!.data.addAll(response.data!.data);
      } else {
        _categories = response.data;
      }

      _currentPageCategories = page;
      _nextPageUrlCategories = response.data!.nextPageUrl;
      _lastPageCategories = response.data!.lastPage;

      notifyListeners();
    }

    _isLoadingMoreCategories = false;
  }

  /// Load next page of categories
  ///
  /// @return {Future<void>}
  Future<void> loadNextPageCategories() async {
    if (_nextPageUrlCategories == null) {
      return;
    }

    if (_currentPageCategories >=
        (_lastPageCategories ?? _currentPageCategories)) {
      return;
    }

    await getListCategories(_currentPageCategories + 1, append: true);
  }

  /// Get top books most viewed
  ///
  /// @param {number} page - The page number
  /// @param {boolean} append - Whether to append the results or replace
  ///
  /// @return Future<void>
  Future<void> getMostViewedBooks(int page, {bool append = false}) async {
    if (_isLoadingMoreMostViewedBooks) return;
    _isLoadingMoreMostViewedBooks = true;

    final response = await getBooksUseCase(
      BookParams(
        page: page,
        limit: AppConstants.LIMIT_BOOK,
        mostViewed: AppConstants.TRUE,
        order: AppConstants.DEFAULT_ORDER,
      ),
    );

    if (response.data != null) {
      if (append && _mostViewedBooks != null) {
        _mostViewedBooks!.data.addAll(response.data!.data);
      } else {
        _mostViewedBooks = response.data;
      }

      _currentPageMostViewedBooks = page;
      _nextPageUrlMostViewedBooks = response.data!.nextPageUrl;
      _lastPageMostViewedBooks = response.data!.lastPage;

      notifyListeners();
    }

    _isLoadingMoreMostViewedBooks = false;
  }

  /// Load next page of most viewed books
  ///
  /// @return {Future<void>}
  Future<void> loadNextPageMostViewedBooks() async {
    if (_nextPageUrlMostViewedBooks == null) {
      return;
    }

    if (_currentPageMostViewedBooks >=
        (_lastPageMostViewedBooks ?? _currentPageMostViewedBooks)) {
      return;
    }

    await getMostViewedBooks(_currentPageMostViewedBooks + 1, append: true);
  }

    /// Get top books most new released
  ///
  /// @param {number} page - The page number
  /// @param {boolean} append - Whether to append the results or replace
  ///
  /// @return Future<void>
  Future<void> getNewReleasedBooks(int page, {bool append = false}) async {
    if (_isLoadingMoreNewReleasedBooks) return;
    _isLoadingMoreNewReleasedBooks = true;

    final response = await getBooksUseCase(
      BookParams(
        page: page,
        limit: AppConstants.LIMIT_BOOK,
        latest: AppConstants.TRUE,
        order: AppConstants.DEFAULT_ORDER,
      ),
    );

    if (response.data != null) {
      if (append && _newReleasedBooks != null) {
        _newReleasedBooks!.data.addAll(response.data!.data);
      } else {
        _newReleasedBooks = response.data;
      }

      _currentPageNewReleasedBooks = page;
      _nextPageUrlNewReleasedBooks = response.data!.nextPageUrl;
      _lastPageNewReleasedBooks = response.data!.lastPage;

      notifyListeners();
    }

    _isLoadingMoreNewReleasedBooks = false;
  }

  /// Load next page of new released books
  ///
  /// @return {Future<void>}
  Future<void> loadNextPageNewReleasedBooks() async {
    if (_nextPageUrlNewReleasedBooks == null) {
      return;
    }

    if (_currentPageNewReleasedBooks >=
        (_lastPageNewReleasedBooks ?? _currentPageNewReleasedBooks)) {
      return;
    }

    await getNewReleasedBooks(_currentPageNewReleasedBooks + 1, append: true);
  }

  /// The method add book to wishlist
  /// 
  /// @param bookId The id of book
  /// 
  /// @return Future<void>
  Future<void> addBookToWishlist(int bookId) async {
      
  }

  /// The method remove book from wishlist
  /// 
  /// @param bookId The id of book
  /// 
  /// @return Future<void>
  Future<void> deleteBookFromWishlist(int bookId) async {
      print('Remove book $bookId from wishlist');
  }
}
