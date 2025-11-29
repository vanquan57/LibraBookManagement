import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/helper/calculate_card_width.dart';
import 'package:mobile/features/cart/presentation/provider/cart_provider.dart';
import 'package:mobile/features/home/presentation/provider/home_provider.dart';
import 'package:mobile/features/home/presentation/screens/carousel.dart';
import 'package:mobile/features/wishlist/presentation/provider/wishlist_provider.dart';
import 'package:mobile/share/components/book/book_card.dart';
import 'package:mobile/share/components/category/category_card.dart';
import 'package:mobile/share/components/styled_dialog.dart';
import 'package:mobile/core/helper/protected_route.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollTopBorrowedController;
  late final ScrollController _scrollCategoriesController;
  late final ScrollController _scrollMostViewedController;

  @override
  void initState() {
    super.initState();
    _scrollTopBorrowedController = ScrollController()
      ..addListener(_onScrollTopBorrowed);
    _scrollCategoriesController = ScrollController()
      ..addListener(_onScrollCategories);
    _scrollMostViewedController = ScrollController()
      ..addListener(_onScrollMostViewed);

    // Load initial top borrowed books
    Future.microtask(() {
      _refreshWishlist();
      _refreshCart();
      context.read<HomeProvider>().getTopBorrowedBooks(1);
      context.read<HomeProvider>().getListCategories(1);
      context.read<HomeProvider>().getMostViewedBooks(1);
      context.read<HomeProvider>().getNewReleasedBooks(1);
    });
  }

  @override
  void dispose() {
    _scrollTopBorrowedController.dispose();
    _scrollCategoriesController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshWishlist();
    _refreshCart();
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
    return Consumer2<WishlistProvider, CartProvider>(
      builder: (context, wishlistProvider, cartProvider, _) {
        _showWishlistDialog(wishlistProvider);
        _showCartDialog(cartProvider);

        return Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              const Carousel(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBooksHeader(
                      "Top Sách",
                      "Top sách được mượn nhiều nhất",
                    ),
                    SizedBox(height: 16.h),
                    _buildTopBorrowedBooks(),
                    SizedBox(height: 16.h),
                    _buildTopBooksHeader("Thể loại", "Thể loại"),
                    SizedBox(height: 16.h),
                    _buildCategories(),
                    SizedBox(height: 16.h),
                    _buildTopBooksHeader(
                      "Sách được xem nhiều",
                      "Top sách được xem nhiều",
                    ),
                    SizedBox(height: 16.h),
                    _buildMostViewedBooks(),
                    SizedBox(height: 16.h),
                    Image.asset(
                      'assets/images/banner.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16.h),
                    _buildTopBooksHeader("Sách mới", "Sách mới"),
                    SizedBox(height: 16.h),
                    _buildNewReleasedBooks(),
                    SizedBox(height: 16.h),
                    _buildTopBooksHeader("Sách viral", "Sách viral"),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      height: 180.h,
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              'assets/images/viralLeft.png',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/viralRightTop.png',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'assets/images/viralBottomLeft.png',
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Image.asset(
                                          'assets/images/viralBottomRight.png',
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    _buildServicesSection(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Build top header
  ///
  /// @param {String} title - The title of the section
  /// @param {String?} subtitle - The subtitle of the section
  ///
  /// @return {Widget}
  Widget _buildTopBooksHeader(String title, String? subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 20.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xFFFF6E38),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF6E38),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle ?? "",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  /// Build top borrowed books section
  ///
  /// @return {Widget}
  Widget _buildTopBorrowedBooks() {
    return Consumer3<HomeProvider, WishlistProvider, CartProvider>(
      builder: (context, homeProvider, wishlistProvider, cartProvider, _) {
        final books = homeProvider.topBorrowedBooks?.data ?? [];

        if (books.isEmpty) {
          return SizedBox(
            height: 340.h,
            child: const Center(child: CircularProgressIndicator()),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 340.h,
              child: ListView.builder(
                controller: _scrollTopBorrowedController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Container(
                    width: cardWidth,
                    margin: EdgeInsets.only(right: 12.w),
                    child: BookCard(
                      bookId: book.id,
                      image: book.image,
                      name: book.name,
                      authorName: book.author!.name,
                      averageStar: book.averageStar ?? 0,
                      feedbacksCount: book.feedbacksCount ?? 0,
                      baseImageUrl: AppConstants.BASE_URL_IMAGE,
                      isInWishlist: wishlistProvider.isInWishList(book.id),
                      onQuickView: () => print('Quick view book ${book.id}'),
                      onAddToCart: () async {
                        if (await ensureLogin(context)) {
                          cartProvider.addToCart([
                            {'book_id': book.id, 'quantity': 1}
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
                },
              ),
            ),
            SizedBox(height: 12.h),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('See all top borrowed books');
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
                child: const Text('Xem tất cả'),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Handle scroll event for top borrowed books list
  void _onScrollTopBorrowed() {
    if (_scrollTopBorrowedController.position.pixels >=
        _scrollTopBorrowedController.position.maxScrollExtent - 100) {
      // Load next page when near end
      context.read<HomeProvider>().loadNextPageTopBorrowedBooks();
    }
  }

  /// Build categories section
  ///
  /// @return {Widget}
  Widget _buildCategories() {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        final categories = homeProvider.categories?.data ?? [];

        if (categories.isEmpty) {
          return SizedBox(
            height: 120.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final screenWidth = MediaQuery.of(context).size.width;
        final cardWidth = calculateCardWidth(
          screenWidth,
          minCardWidth: 100.w,
          maxCardWidth: 140.w,
          horizontalPadding: 40.w,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120.h,
              child: ListView.builder(
                controller: _scrollCategoriesController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Container(
                    width: cardWidth,
                    margin: EdgeInsets.only(right: 12.w),
                    child: CategoryCard(
                      categoryId: category.id,
                      name: category.name,
                      onTap: () =>
                          print('Navigate to category detail ${category.id}'),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /// Handle scroll event for categories list
  void _onScrollCategories() {
    if (_scrollCategoriesController.position.pixels >=
        _scrollCategoriesController.position.maxScrollExtent - 100) {
      // Load next page when near end
      context.read<HomeProvider>().loadNextPageCategories();
    }
  }

  /// Build top borrowed books section
  ///
  /// @return {Widget}
  Widget _buildMostViewedBooks() {
    return Consumer3<HomeProvider, WishlistProvider, CartProvider>(
      builder: (context, homeProvider, wishlistProvider, cartProvider, _) {
        final books = homeProvider.mostViewedBooks?.data ?? [];

        if (books.isEmpty) {
          return SizedBox(
            height: 340.h,
            child: const Center(child: CircularProgressIndicator()),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 340.h,
              child: ListView.builder(
                controller: _scrollMostViewedController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Container(
                    width: cardWidth,
                    margin: EdgeInsets.only(right: 12.w),
                    child: BookCard(
                      bookId: book.id,
                      image: book.image,
                      name: book.name,
                      authorName: book.author!.name,
                      averageStar: book.averageStar ?? 0,
                      feedbacksCount: book.feedbacksCount ?? 0,
                      baseImageUrl: AppConstants.BASE_URL_IMAGE,
                      isInWishlist: wishlistProvider.isInWishList(book.id),
                      onQuickView: () => print('Quick view book ${book.id}'),
                      onAddToCart: () async {
                        if (await ensureLogin(context)) {
                          cartProvider.addToCart([
                            {'book_id': book.id, 'quantity': 1}
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
                },
              ),
            ),
            SizedBox(height: 12.h),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('See all top borrowed books');
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
                child: const Text('Xem tất cả'),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Handle scroll event for most viewed books list
  void _onScrollMostViewed() {
    if (_scrollMostViewedController.position.pixels >=
        _scrollMostViewedController.position.maxScrollExtent - 100) {
      // Load next page when near end
      context.read<HomeProvider>().loadNextPageMostViewedBooks();
    }
  }

  /// Build top new released books section
  ///
  /// @return {Widget}
  Widget _buildNewReleasedBooks() {
    return Consumer3<HomeProvider, WishlistProvider, CartProvider>(
      builder: (context, homeProvider, wishlistProvider, cartProvider, _) {
        final books = homeProvider.newReleasedBooks?.data ?? [];

        if (books.isEmpty) {
          return SizedBox(
            height: 340.h,
            child: const Center(child: CircularProgressIndicator()),
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    onQuickView: () => print('Quick view book ${book.id}'),
                    onAddToCart: () async {
                      if (await ensureLogin(context)) {
                        cartProvider.addToCart([
                          {'book_id': book.id, 'quantity': 1}
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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<HomeProvider>().loadNextPageNewReleasedBooks();
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
                child: const Text('Xem thêm'),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Build services section
  ///
  /// @return {Widget}
  Widget _buildServicesSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceItem(
          icon: Icons.local_shipping_outlined,
          title: 'SÁCH',
          subtitle: 'Sách đa dạng',
        ),
        _buildServiceItem(
          icon: Icons.headset_mic_outlined,
          title: 'GIỜ LÀM VIỆC',
          subtitle: 'Từ thứ 2 đến thứ 7, 9 AM - 6 PM',
        ),
        _buildServiceItem(
          icon: Icons.verified_user_outlined,
          title: 'THAM GIA',
          subtitle: 'Khuyến mãi độc quyền và sự kiện',
        ),
      ],
    );
  }

  /// Build individual service item
  ///
  /// @param {IconData} icon - The icon to display
  /// @param {String} title - The title of the service
  /// @param {String} subtitle - The subtitle of the service
  ///
  /// @return {Widget}
  Widget _buildServiceItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
            child: Container(
              margin: EdgeInsets.all(8.w),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFDB4444),
              ),
              child: Icon(icon, color: Colors.white, size: 40.sp),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              subtitle,
              style: TextStyle(fontSize: 12.sp, color: Colors.black87),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
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
            message: cartProvider.isSuccess ? cartProvider.message : cartProvider.errorMessage,
            isSuccess: cartProvider.isSuccess,
          ),
        );
      });
    }
  }
}
