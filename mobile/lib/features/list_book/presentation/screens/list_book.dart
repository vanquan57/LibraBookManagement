import 'package:flutter/material.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/helper/calculate_card_width.dart';
import 'package:mobile/core/helper/protected_route.dart';
import 'package:mobile/features/cart/presentation/provider/cart_provider.dart';
import 'package:mobile/features/list_book/presentation/provider/list_book_provider.dart';
import 'package:mobile/features/wishlist/presentation/provider/wishlist_provider.dart';
import 'package:mobile/share/components/book/book_card.dart';
import 'package:mobile/share/components/layouts/footer.dart';
import 'package:mobile/share/components/layouts/header.dart';
import 'package:mobile/share/components/styled_dialog.dart';
import 'package:mobile/share/provider/global/header_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListBookScreen extends StatefulWidget {
  final String? filter;
  final int? categoryId;

  const ListBookScreen({
    super.key,
    this.filter,
    this.categoryId,
  });

  @override
  State<ListBookScreen> createState() => _ListBookScreenState();
}

class _ListBookScreenState extends State<ListBookScreen> {
  int? _selectedCategory;
  final List<int> _selectedAuthors = [];
  final List<int> _selectedPublishers = [];
  String _activeFilter = '';

  final List<Map<String, String>> _filters = [
    {'id': 'most-borrowed', 'name': 'Mượn nhiều nhất'},
    {'id': 'most-viewed', 'name': 'Xem nhiều nhất'},
    {'id': 'most-loved', 'name': 'Yêu thích nhiều nhất'},
  ];

  @override
  void initState() {
    super.initState();
    // Load initial data
    if (widget.filter != null) {
      _activeFilter = widget.filter!;
    }
    if (widget.categoryId != null) {
      _selectedCategory = widget.categoryId!;
    }
    Future.microtask(() {
      _loadInitialData();
      _refreshWishlist();
      _refreshCart();
      _reloadBooks();
    });
  }

  /// Load initial data (categories, authors, publishers, books)
  ///
  /// @return void
  void _loadInitialData() {
    Future.microtask(() async {
      await context.read<ListBookProvider>().initializeData();
    });
  }

  /// Reload books with current filters
  ///
  /// @return void
  void _reloadBooks() {
    final headerProvider = context.read<HeaderProvider>();
    final searchQuery = headerProvider.querySearch;

    context.read<ListBookProvider>().getBooks(
      page: 1,
      searchQuery: searchQuery.isEmpty ? null : searchQuery,
      categoryId: _selectedCategory,
      authorIds: _selectedAuthors.isEmpty ? null : _selectedAuthors,
      publisherIds: _selectedPublishers.isEmpty ? null : _selectedPublishers,
      mostBorrowed: _activeFilter == 'most-borrowed' ? AppConstants.TRUE : null,
      mostViewed: _activeFilter == 'most-viewed' ? AppConstants.TRUE : null,
      mostLoved: _activeFilter == 'most-loved' ? AppConstants.TRUE : null,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final headerProvider = context.watch<HeaderProvider>();
    super.didChangeDependencies();

    // Listen to search query changes
    if (headerProvider.querySearch.isEmpty) {
      headerProvider.clearQuerySearch();
    }
    Future.microtask(() {
      _reloadBooks();
    });
  }

  /// Refresh wishlist data
  ///
  /// @return void
  void _refreshWishlist() {
    Future.microtask(() {
      context.read<WishlistProvider>().initializeWishList();
    });
  }

  /// Refresh cart data
  ///
  /// @return void
  void _refreshCart() {
    Future.microtask(() {
      context.read<CartProvider>().getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<WishlistProvider, CartProvider, ListBookProvider>(
      builder: (context, wishlistProvider, cartProvider, listBookProvider, _) {
        _showWishlistDialog(wishlistProvider);
        _showCartDialog(cartProvider);

        return Scaffold(
          appBar: const Header(),
          body: Stack(
            children: [
              // Main content with footer
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: _buildMainContent(),
                    ),
                    const Footer(),
                  ],
                ),
              ),

              // Sidebar Overlay
              if (listBookProvider.isSidebarOpen)
                GestureDetector(
                  onTap: () => listBookProvider.closeSidebar(),
                  child: Container(color: Colors.black.withOpacity(0.5)),
                ),

              // Sidebar
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: listBookProvider.isSidebarOpen ? 0 : -300,
                top: 0,
                bottom: 0,
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(2, 0),
                      ),
                    ],
                  ),
                  child: _buildSidebarContent(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Build sidebar content
  ///
  /// @return {Widget}
  Widget _buildSidebarContent() {
    return Column(
      children: [
        // Header with close button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bộ lọc',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<ListBookProvider>().closeSidebar();
                },
                icon: const Icon(Icons.close, size: 24, color: Colors.black87),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),

        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categories Section
                _buildFilterSection(
                  icon: Icons.grid_view,
                  title: 'Danh mục',
                  child: Consumer<ListBookProvider>(
                    builder: (context, provider, _) {
                      final categories = provider.categories?.data ?? [];

                      if (categories.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      return Column(
                        children: categories.map((category) {
                          return RadioListTile<int>(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            value: category.id,
                            groupValue: _selectedCategory,
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value;
                              });
                              _reloadBooks();
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Authors Section
                _buildFilterSection(
                  icon: Icons.person_outline,
                  title: 'Tác giả',
                  child: Consumer<ListBookProvider>(
                    builder: (context, provider, _) {
                      final authors = provider.authors?.data ?? [];

                      if (authors.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      return Column(
                        children: authors.map((author) {
                          return CheckboxListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              author.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            value: _selectedAuthors.contains(author.id),
                            onChanged: (checked) {
                              setState(() {
                                if (checked == true) {
                                  _selectedAuthors.add(author.id);
                                } else {
                                  _selectedAuthors.remove(author.id);
                                }
                              });
                              _reloadBooks();
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Publishers Section
                _buildFilterSection(
                  icon: Icons.business_outlined,
                  title: 'Nhà xuất bản',
                  child: Consumer<ListBookProvider>(
                    builder: (context, provider, _) {
                      final publishers = provider.publishers?.data ?? [];

                      if (publishers.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      return Column(
                        children: publishers.map((publisher) {
                          return CheckboxListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              publisher.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            value: _selectedPublishers.contains(publisher.id),
                            onChanged: (checked) {
                              setState(() {
                                if (checked == true) {
                                  _selectedPublishers.add(publisher.id);
                                } else {
                                  _selectedPublishers.remove(publisher.id);
                                }
                              });
                              _reloadBooks();
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Build filter section with icon and title
  ///
  /// @param {IconData} icon
  /// @param {String} title
  /// @param {Widget} child
  ///
  /// @return {Widget}
  Widget _buildFilterSection({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: Colors.deepOrange.shade700,
                    weight: 700,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: child,
          ),
        ],
      ),
    );
  }

  /// Build main content area
  ///
  /// @return {Widget}
  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  final isActive = _activeFilter == filter['id'];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _activeFilter = filter['id']!;
                        });
                        _reloadBooks();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isActive
                            ? Colors.deepOrange
                            : Colors.grey.shade200,
                        foregroundColor: isActive
                            ? Colors.white
                            : Colors.black87,
                        elevation: isActive ? 2 : 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(filter['name']!),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Books Grid
            _buildBooksGrid(),
          ],
        ),
      ),
    );
  }

  /// Show wishlist action result dialog
  ///
  /// @param {WishlistProvider} wishlistProvider
  ///
  /// @return {void}
  void _showWishlistDialog(WishlistProvider wishlistProvider) {
    if (wishlistProvider.isShowDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        wishlistProvider.isShowDialog = false;
        showDialog(
          context: context,
          builder: (context) => StyledDialog(
            message: wishlistProvider.message,
            isSuccess: wishlistProvider.isSuccess,
          ),
        );
      });
    }
  }

  /// Show Cart action result dialog
  ///
  /// @param {CartProvider} cartProvider
  ///
  /// @return {void}
  void _showCartDialog(CartProvider cartProvider) {
    if (cartProvider.isShowDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        cartProvider.isShowDialog = false;
        showDialog(
          context: context,
          builder: (context) => StyledDialog(
            message: cartProvider.isSuccess
                ? cartProvider.message
                : cartProvider.errorMessage,
            isSuccess: cartProvider.isSuccess,
          ),
        );
      });
    }
  }

  /// Build books grid
  ///
  /// @return {Widget}
  Widget _buildBooksGrid() {
    return Consumer3<ListBookProvider, WishlistProvider, CartProvider>(
      builder: (context, listBookProvider, wishlistProvider, cartProvider, _) {
        final books = listBookProvider.books?.data ?? [];
        final isLoading = listBookProvider.isLoadingBooks;

        if (isLoading && books.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(32),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (books.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Center(
              child: Column(
                children: [
                  Icon(Icons.book_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Không tìm thấy sách',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }

        final screenWidth = MediaQuery.of(context).size.width;
        final cardWidth = calculateCardWidth(
          screenWidth,
          minCardWidth: 150.w,
          maxCardWidth: 200.w,
          horizontalPadding: 40.w,
        );

        return Column(
          children: [
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: books.map((book) {
                return SizedBox(
                  width: cardWidth,
                  height: 340.h,
                  child: BookCard(
                    bookId: book.id,
                    image: book.image,
                    name: book.name,
                    authorName: book.author!.name,
                    averageStar: book.averageStar ?? 0,
                    feedbacksCount: book.feedbacksCount ?? 0,
                    baseImageUrl: AppConstants.BASE_URL_IMAGE,
                    isInWishlist: wishlistProvider.isInWishList(book.id),
                    onAddToCart: () async {
                      if (await ensureLogin(context)) {
                        cartProvider.addToCart([
                          {'book_id': book.id, 'quantity': 1},
                        ]);
                      }
                    },
                    onAddToWishlist: () async {
                      if (await ensureLogin(context)) {
                        wishlistProvider.addToWishList(book.id);
                      }
                    },
                    onRemoveFromWishlist: () async {
                      if (await ensureLogin(context)) {
                        wishlistProvider.removeFromWishList(book.id);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 12.h),
            if (listBookProvider.books?.nextPageUrl != null)
              Center(
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          final headerProvider = context.read<HeaderProvider>();
                          final searchQuery = headerProvider.querySearch;

                          listBookProvider.getBooks(
                            page: listBookProvider.currentPageBooks + 1,
                            append: true,
                            searchQuery: searchQuery.isEmpty
                                ? null
                                : searchQuery,
                            categoryId: _selectedCategory,
                            authorIds: _selectedAuthors.isEmpty
                                ? null
                                : _selectedAuthors,
                            publisherIds: _selectedPublishers.isEmpty
                                ? null
                                : _selectedPublishers,
                            mostBorrowed: _activeFilter == 'most-borrowed'
                                ? AppConstants.TRUE
                                : null,
                            mostViewed: _activeFilter == 'most-viewed'
                                ? AppConstants.TRUE
                                : null,
                            mostLoved: _activeFilter == 'most-loved'
                                ? AppConstants.TRUE
                                : null,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDB4444),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Xem thêm'),
                ),
              ),
          ],
        );
      },
    );
  }
}
