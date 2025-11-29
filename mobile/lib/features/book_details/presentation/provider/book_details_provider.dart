import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/features/book_details/domain/usecase/book/get_book_details.dart';
import 'package:mobile/features/book_details/domain/usecase/book/get_book_same_category.dart';
import 'package:mobile/features/book_details/domain/usecase/feedback/create_feedback.dart';
import 'package:mobile/features/book_details/domain/usecase/feedback/get_feedbacks.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/feedback/feedback.dart' as model;

@injectable
class BookDetailsProvider extends ChangeNotifier {
  final GetBookDetailUseCase getBookDetailUseCase;
  final GetBookSameCategoryUseCase getBookSameCategoryUseCase;
  final GetFeedbacksUseCase getFeedbacksUseCase;
  final CreateFeedbackUseCase createFeedbackUseCase;

  // SYNC constructor
  BookDetailsProvider({
    required this.getBookDetailUseCase,
    required this.getBookSameCategoryUseCase,
    required this.getFeedbacksUseCase,
    required this.createFeedbackUseCase,
  });

  // Book details state
  Book? _book;
  Book? get book => _book;
  bool _isLoadingBook = false;
  bool get isLoadingBook => _isLoadingBook;

  // Feedbacks state
  List<model.Feedback> _feedbacks = [];
  List<model.Feedback> get feedbacks => _feedbacks;
  bool _isLoadingFeedbacks = false;
  bool get isLoadingFeedbacks => _isLoadingFeedbacks;

  // Books same category state
  List<Book> _booksSameCategory = [];
  List<Book> get booksSameCategory => _booksSameCategory;
  bool _isLoadingBooksSameCategory = false;
  bool get isLoadingBooksSameCategory => _isLoadingBooksSameCategory;

  // Main image for carousel
  String _mainImage = '';
  String get mainImage => _mainImage;

  // Quantity for add to cart
  int _quantityBookAddToCart = 1;
  int get quantityBookAddToCart => _quantityBookAddToCart;

  // Dialog state for feedback submission
  bool _isShowDialog = false;
  bool get isShowDialog => _isShowDialog;
  String? _message;
  String? get message => _message;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Get book details
  ///
  /// @param {int} bookId
  ///
  /// @return Future<void>
  Future<void> getBookDetails(int bookId) async {
    if (_isLoadingBook) return;
    _isLoadingBook = true;
    notifyListeners();

    final response = await getBookDetailUseCase(bookId);

    if (response.data != null) {
      _book = response.data;
      // Set main image to book's main image
      if (_book!.image.isNotEmpty) {
        _mainImage = _book!.image;
      }
    }

    _isLoadingBook = false;
    notifyListeners();
  }

  /// Get feedbacks for book
  ///
  /// @param {int} bookId
  ///
  /// @return Future<void>
  Future<void> getFeedbacks(int bookId) async {
    if (_isLoadingFeedbacks) return;
    _isLoadingFeedbacks = true;
    notifyListeners();

    final response = await getFeedbacksUseCase(
      FeedbackParams(
        bookId: bookId,
        page: 1,
        limit: AppConstants.LIMIT_INFINITY,
        column: 'created_at',
        order: 'desc',
      ),
    );

    if (response.data != null) {
      _feedbacks = response.data!.data;
    }

    _isLoadingFeedbacks = false;
    notifyListeners();
  }

  /// Get books same category
  ///
  /// @param {int} categoryId
  ///
  /// @return Future<void>
  Future<void> getBooksSameCategory(int categoryId) async {
    if (_isLoadingBooksSameCategory) return;
    _isLoadingBooksSameCategory = true;
    notifyListeners();

    final response = await getBookSameCategoryUseCase(
      categoryId,
      AppConstants.LIMIT_BOOK,
    );

    if (response.data != null) {
      _booksSameCategory = response.data!.data;
    }

    _isLoadingBooksSameCategory = false;
    notifyListeners();
  }

  /// Set main image
  ///
  /// @param {String} imageUrl
  ///
  /// @return void
  void setMainImage(String imageUrl) {
    _mainImage = imageUrl;
    notifyListeners();
  }

  /// Increment quantity
  ///
  /// @return void
  void incrementQuantity() {
    if (_book != null &&
        _book!.quantity != null &&
        _quantityBookAddToCart < _book!.quantity!) {
      _quantityBookAddToCart++;
      notifyListeners();
    }
  }

  /// Decrement quantity
  ///
  /// @return void
  void decrementQuantity() {
    if (_quantityBookAddToCart > 1) {
      _quantityBookAddToCart--;
      notifyListeners();
    }
  }

  /// Reset quantity
  ///
  /// @return void
  void resetQuantity() {
    _quantityBookAddToCart = 1;
    notifyListeners();
  }

  /// Submit feedback
  ///
  /// @param {String} content
  /// @param {int} star
  ///
  /// @return Future<void>
  Future<void> submitFeedback(String content, int star) async {
    _isShowDialog = false;
    _message = null;
    _errorMessage = null;

    if (_book == null) return;

    // Call API to create feedback (form handles all validation)
    final response = await createFeedbackUseCase(
      CreateFeedbackParams(bookId: _book!.id, content: content, star: star),
    );

    if (response.success) {
      _message = response.data ?? 'Gửi đánh giá thành công';

      // Reload feedbacks
      await getFeedbacks(_book!.id);
    } else {
      if (response.errors is Map) {
        _errorMessage = response.errors['error_message']?.toString();
      } else {
        _errorMessage = response.errors?.toString();
      }
    }

    _isShowDialog = true;
    notifyListeners();
  }

  /// Reset dialog state
  ///
  /// @return void
  void resetDialogState() {
    _isShowDialog = false;
    _message = null;
    _errorMessage = null;
    notifyListeners();
  }

  /// Initialize book details page
  ///
  /// @param {int} bookId
  ///
  /// @return Future<void>
  Future<void> initializeBookDetails(int bookId) async {
    await getBookDetails(bookId);

    if (_book != null) {
      await getFeedbacks(bookId);

      // Get books same category if book has categories
      if (_book!.categories != null && _book!.categories!.isNotEmpty) {
        final firstCategoryId = _book!.categories!.first.id;
        await getBooksSameCategory(firstCategoryId);
      }
    }
  }
}
