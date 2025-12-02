import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/helper/calculate_card_width.dart';
import 'package:mobile/core/helper/protected_route.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/core/utils/validators.dart';
import 'package:mobile/features/book_details/presentation/provider/book_details_provider.dart';
import 'package:mobile/features/cart/presentation/provider/cart_provider.dart';
import 'package:mobile/features/wishlist/presentation/provider/wishlist_provider.dart';
import 'package:mobile/share/components/book/book_card.dart';
import 'package:mobile/share/components/feedback/feedback_item.dart';
import 'package:mobile/share/components/styled_dialog.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  final int bookId;
  const BookDetails({super.key, required this.bookId});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  final _feedbackFormKey = GlobalKey<FormState>();
  final _feedbackContentController = TextEditingController();
  int _selectedStar = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<WishlistProvider>().initializeWishList();
      context.read<CartProvider>().getCart();
      context.read<BookDetailsProvider>().initializeBookDetails(widget.bookId);
    });
  }

  @override
  void dispose() {
    _feedbackContentController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<BookDetailsProvider, WishlistProvider, CartProvider>(
      builder:
          (context, bookDetailsProvider, wishlistProvider, cartProvider, _) {
            _showWishlistDialog(wishlistProvider);
            _showCartDialog(cartProvider);
            _showFeedbackDialog(bookDetailsProvider);

            final book = bookDetailsProvider.book;

            if (bookDetailsProvider.isLoadingBook || book == null) {
              return Container(
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            return Container(
              color: Colors.white,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Breadcrumb
                      _buildBreadcrumb(book.name),
                      SizedBox(height: 32.h),

                      // Main content (Image + Info)
                      _buildMainContent(
                        book,
                        bookDetailsProvider,
                        wishlistProvider,
                        cartProvider,
                      ),
                      SizedBox(height: 48.h),

                      // Book description
                      _buildBookDescription(book),
                      SizedBox(height: 48.h),

                      // Book detailed info
                      _buildBookDetailedInfo(book),
                      SizedBox(height: 48.h),

                      // Feedbacks section
                      _buildFeedbacksSection(bookDetailsProvider),
                      SizedBox(height: 48.h),

                      // Books same category
                      _buildBooksSameCategory(
                        bookDetailsProvider,
                        wishlistProvider,
                        cartProvider,
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            );
          },
    );
  }

  /// Build breadcrumb
  ///
  /// @param {String} bookName
  ///
  /// @return {Widget}
  Widget _buildBreadcrumb(String bookName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => context.go(AppRouter.home),
          child: Text(
            'Trang chủ',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            ' / ',
            style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
          ),
        ),
        InkWell(
          onTap: () => context.go(AppRouter.listBook),
          child: Text(
            'Sách',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            ' / ',
            style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
          ),
        ),
        Expanded(
          child: Text(
            bookName.length > 30 ? '${bookName.substring(0, 30)}...' : bookName,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Build main content (images + info)
  ///
  /// @return {Widget}
  Widget _buildMainContent(
    book,
    BookDetailsProvider provider,
    WishlistProvider wishlistProvider,
    CartProvider cartProvider,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 768;

    if (isSmallScreen) {
      return Column(
        children: [
          _buildImagesSection(book, provider, isSmallScreen),
          SizedBox(height: 24.h),
          _buildBookInfo(book, provider, wishlistProvider, cartProvider),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: _buildImagesSection(book, provider, isSmallScreen),
        ),
        SizedBox(width: 40.w),
        Expanded(
          flex: 4,
          child: _buildBookInfo(book, provider, wishlistProvider, cartProvider),
        ),
      ],
    );
  }

  /// Build images section (carousel + main image)
  ///
  /// @return {Widget}
  Widget _buildImagesSection(
    book,
    BookDetailsProvider provider,
    bool isSmallScreen,
  ) {
    final mainImageUrl = AppConstants.BASE_URL_IMAGE + provider.mainImage;
    final images = book.images ?? [];

    if (isSmallScreen) {
      return Column(
        children: [
          // Main image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              mainImageUrl,
              width: double.infinity,
              height: 300.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 300.h,
                  color: Colors.grey[200],
                  child: const Icon(Icons.book, size: 100),
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          // Image carousel
          if (images.isNotEmpty)
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final imageUrl =
                      AppConstants.BASE_URL_IMAGE + images[index].url;
                  return GestureDetector(
                    onTap: () => provider.setMainImage(images[index].url),
                    child: Container(
                      width: 100.w,
                      margin: EdgeInsets.only(right: 12.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.book),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      );
    }

    // Desktop layout
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image carousel (vertical)
        if (images.isNotEmpty)
          SizedBox(
            width: 100.w,
            child: Column(
              children: images.map((image) {
                final imageUrl = AppConstants.BASE_URL_IMAGE + image.url;
                return GestureDetector(
                  onTap: () => provider.setMainImage(image.url),
                  child: Container(
                    width: 100.w,
                    height: 138.h,
                    margin: EdgeInsets.only(bottom: 16.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.book),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        SizedBox(width: 30.w),
        // Main image
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              mainImageUrl,
              height: 600.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 600.h,
                  color: Colors.grey[200],
                  child: const Icon(Icons.book, size: 150),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Build book info section
  ///
  /// @return {Widget}
  Widget _buildBookInfo(
    book,
    BookDetailsProvider provider,
    WishlistProvider wishlistProvider,
    CartProvider cartProvider,
  ) {
    final categories = book.categories?.map((c) => c.name).join(', ') ?? '';
    final isInWishlist = wishlistProvider.isInWishList(book.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Book name
        Text(
          book.name,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16.h),

        // Rating and stock status
        Row(
          children: [
            // Stars
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  size: 16.sp,
                  color: index < (book.averageStar ?? 0)
                      ? const Color(0xFFFF6E38)
                      : Colors.grey[400],
                );
              }),
            ),
            SizedBox(width: 8.w),
            Text(
              '(${provider.feedbacks.length} Nhận xét)',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
            SizedBox(width: 16.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: const Color(0xFFFF6E38), width: 2),
                ),
              ),
              child: Text(
                (book.quantity ?? 0) > 0 ? 'Còn sách' : 'Hết sách',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: (book.quantity ?? 0) > 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Categories
        if (categories.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thể loại: ',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Text(
                  categories,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                ),
              ),
            ],
          ),
        if (categories.isNotEmpty) SizedBox(height: 16.h),

        // Mini description
        if (book.miniDescription != null)
          Html(
            data: book.miniDescription!,
            style: {
              "body": Style(
                fontSize: FontSize(14.sp),
                lineHeight: LineHeight(1.5),
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                color: Colors.black45,
              ),
              "p": Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                color: Colors.black45,
              ),
            },
          ),
        SizedBox(height: 24.h),

        Divider(color: Colors.grey[300]),
        SizedBox(height: 24.h),

        // Quantity selector and action buttons
        Row(
          children: [
            // Quantity selector
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => provider.decrementQuantity(),
                    child: Container(
                      width: 40.w,
                      height: 44.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey[400]!),
                        ),
                      ),
                      child: const Text(
                        '-',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                  ),
                  Container(
                    width: 80.w,
                    height: 44.h,
                    alignment: Alignment.center,
                    child: Text(
                      '${provider.quantityBookAddToCart}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => provider.incrementQuantity(),
                    child: Container(
                      width: 40.w,
                      height: 44.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.grey[400]!),
                        ),
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Add to cart button
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (await ensureLogin(context)) {
                    cartProvider.addToCart([
                      {
                        'book_id': book.id,
                        'quantity': provider.quantityBookAddToCart,
                      },
                    ]);
                    provider.resetQuantity();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6E38),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 8.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                child: Text(
                  'Thêm vào giỏ mượn',
                  style: TextStyle(fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Wishlist button
            InkWell(
              onTap: () async {
                if (await ensureLogin(context)) {
                  if (isInWishlist) {
                    wishlistProvider.removeFromWishList(book.id);
                  } else {
                    wishlistProvider.addToWishList(book.id);
                  }
                }
              },
              child: Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isInWishlist
                        ? const Color(0xFFFF6E38)
                        : Colors.grey[400]!,
                  ),
                  borderRadius: BorderRadius.circular(4.r),
                  color: isInWishlist ? const Color(0xFFFF6E38) : Colors.white,
                ),
                child: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  color: isInWishlist ? Colors.white : Colors.grey[700],
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),

        // Policy section
        _buildPolicySection(),
      ],
    );
  }

  /// Build policy section (delivery + return)
  ///
  /// @return {Widget}
  Widget _buildPolicySection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        children: [
          // Delivery policy
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  size: 40.sp,
                  color: Colors.black87,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Giao hàng miễn phí',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Giao hàng trong vòng 24h',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[700],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          // Return policy
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(Icons.autorenew, size: 40.sp, color: Colors.black87),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đổi trả trong 7 ngày',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Đổi trả trong vòng 7 ngày',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[700],
                          decoration: TextDecoration.underline,
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
    );
  }

  /// Build book description section
  ///
  /// @return {Widget}
  Widget _buildBookDescription(book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mô tả sách',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Divider(color: Colors.grey[300]),
        SizedBox(height: 16.h),
        if (book.detailsDescription != null)
          Html(
            data: book.detailsDescription!,
            style: {
              "body": Style(
                fontSize: FontSize(14.sp),
                lineHeight: LineHeight(1.5),
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                color: Colors.black,
              ),
              "p": Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                color: Colors.black,
              ),
            },
          ),
      ],
    );
  }

  /// Build book detailed info section
  ///
  /// @return {Widget}
  Widget _buildBookDetailedInfo(book) {
    final coverTypeMap = {1: 'Bìa mềm', 2: 'Bìa cứng'};

    final infoItems = [
      {'label': 'Nhà xuất bản', 'value': book.publisher?.name ?? '-'},
      {
        'label': 'Năm xuất bản',
        'value': book.publicationDate != null
            ? DateTime.parse(book.publicationDate!).year.toString()
            : '-',
      },
      {'label': 'Tác giả', 'value': book.author?.name ?? '-'},
      {'label': 'Kích thước', 'value': book.size ?? '-'},
      {'label': 'Số trang', 'value': '${book.page ?? '-'}'},
      {'label': 'Loại bìa', 'value': coverTypeMap[book.coverType] ?? '-'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin chi tiết sách',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Divider(color: Colors.grey[300]),
        SizedBox(height: 16.h),
        ...infoItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == infoItems.length - 1;

          return Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
                left: BorderSide(color: Colors.grey[300]!),
                right: BorderSide(color: Colors.grey[300]!),
                bottom: isLast
                    ? BorderSide(color: Colors.grey[300]!)
                    : BorderSide.none,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 150.w,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.grey[300]!)),
                  ),
                  child: Text(
                    item['label']!,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Text(
                      item['value']!,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  /// Build feedbacks section
  ///
  /// @return {Widget}
  Widget _buildFeedbacksSection(BookDetailsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Người mượn đánh giá',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Divider(color: Colors.grey[300]),
        SizedBox(height: 16.h),

        // Feedback form
        _buildFeedbackForm(provider),
        SizedBox(height: 24.h),

        // Feedback list
        if (provider.isLoadingFeedbacks)
          const Center(child: CircularProgressIndicator())
        else if (provider.feedbacks.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.all(32.h),
              child: Text(
                'Chưa có đánh giá nào',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
              ),
            ),
          )
        else
          Column(
            children: provider.feedbacks
                .map((feedback) => FeedbackItem(feedback: feedback))
                .toList(),
          ),
      ],
    );
  }

  /// Build feedback form
  ///
  /// @return {Widget}
  Widget _buildFeedbackForm(BookDetailsProvider provider) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        border: Border.all(color: const Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Form(
        key: _feedbackFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Star rating
            FormField<int>(
              initialValue: _selectedStar,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: Validators.feedbackStar,
              builder: (formFieldState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đánh giá: $_selectedStar sao',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: List.generate(5, (index) {
                        final starIndex = index + 1;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedStar = starIndex;
                            });
                            formFieldState.didChange(starIndex);
                          },
                          child: Icon(
                            Icons.star,
                            size: 24.sp,
                            color: starIndex <= _selectedStar
                                ? Colors.amber
                                : Colors.grey[400],
                          ),
                        );
                      }),
                    ),
                    if (formFieldState.hasError)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          formFieldState.errorText!,
                          style: TextStyle(fontSize: 12.sp, color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            ),
            SizedBox(height: 16.h),

            // Content textarea
            Text(
              'Nội dung đánh giá:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _feedbackContentController,
              maxLines: 5,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: 'Nhập nội dung đánh giá...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: const BorderSide(color: Color(0xFF007BFF)),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: Validators.feedbackContent,
            ),
            SizedBox(height: 16.h),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (await ensureLogin(context)) {
                    if (_feedbackFormKey.currentState!.validate()) {
                      await provider.submitFeedback(
                        _feedbackContentController.text,
                        _selectedStar,
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6E38),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                child: Text('Gửi đánh giá', style: TextStyle(fontSize: 16.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build books same category section
  ///
  /// @return {Widget}
  Widget _buildBooksSameCategory(
    BookDetailsProvider bookDetailsProvider,
    WishlistProvider wishlistProvider,
    CartProvider cartProvider,
  ) {
    if (bookDetailsProvider.isLoadingBooksSameCategory) {
      return const Center(child: CircularProgressIndicator());
    }

    if (bookDetailsProvider.booksSameCategory.isEmpty) {
      return const SizedBox.shrink();
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
        _buildTopBooksHeader('Sách cùng thể loại', null),
        SizedBox(height: 24.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: bookDetailsProvider.booksSameCategory.map((book) {
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
      ],
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
        if (subtitle != null) ...[
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ],
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

  /// Show Feedback submission result dialog
  ///
  /// @param {BookDetailsProvider} bookDetailsProvider
  ///
  /// @return {void}
  void _showFeedbackDialog(BookDetailsProvider bookDetailsProvider) {
    if (bookDetailsProvider.isShowDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (bookDetailsProvider.message != null) {
          // Success case - reset form
          if (!mounted) return;

          setState(() {
            _selectedStar = 0;
          });
          _feedbackFormKey.currentState!.reset();
          _feedbackContentController.clear();

          final successMessage = bookDetailsProvider.message!;

          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) =>
                StyledDialog(message: successMessage, isSuccess: true),
          );
        } else if (bookDetailsProvider.errorMessage != null) {
          // Error case
          if (!mounted) return;

          final errorMessage = bookDetailsProvider.errorMessage!;

          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) =>
                StyledDialog(message: errorMessage, isSuccess: false),
          );
        }

        bookDetailsProvider.resetDialogState();
      });
    }
  }
}
