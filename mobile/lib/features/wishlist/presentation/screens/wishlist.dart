import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/helper/calculate_card_width.dart';
import 'package:mobile/features/wishlist/presentation/provider/wishlist_provider.dart';
import 'package:mobile/share/components/book/book_card.dart';
import 'package:mobile/share/components/styled_dialog.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  void initState() {
    super.initState();
    _refreshWishlist();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshWishlist();
  }

  /// Refresh wishlist data
  /// 
  /// @return void
  void _refreshWishlist() {
    Future.microtask(() {
      context.read<WishlistProvider>().initializeWishList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, _) {
        final books = wishlistProvider.wishList;
        _showWishlistDialog(wishlistProvider);

        return Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Danh sách yêu thích',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    if (books.isNotEmpty)
                      Text(
                        '( ${wishlistProvider.wishList.length} )',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20.h),
                _buildWishlistBooks(wishlistProvider),
                SizedBox(height: 20.h),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Add all to cart functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6E38),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Thêm tất cả vào giỏ mượn',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWishlistBooks(WishlistProvider wishlistProvider) {
    final books = wishlistProvider.wishList;

    if (books.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60.h),
            Icon(Icons.favorite_border, size: 80.sp, color: Colors.grey[400]),
            SizedBox(height: 16.h),
            Text(
              'Danh sách yêu thích trống',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Hãy thêm sách vào danh sách yêu thích của bạn',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
            ),
          ],
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

    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: books.map((wishlistItem) {
        final book = wishlistItem.book;
        return SizedBox(
          width: cardWidth,
          height: 340.h,
          child: BookCard(
            bookId: book.id,
            image: book.image,
            name: book.name,
            authorName: book.author!.name,
            averageStar: book.averageStar,
            feedbacksCount: book.feedbacksCount,
            baseImageUrl: AppConstants.BASE_URL_IMAGE,
            isInWishlist: true,
            isWishlistMode: true,
            onAddToCart: () => print('Add to cart book ${book.id}'),
            onDelete: () {
              wishlistProvider.removeFromWishList(book.id);
            },
            onTap: () => print('Navigate to book detail ${book.id}'),
          ),
        );
      }).toList(),
    );
  }

  /// Show wishlist action result dialog
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
}
