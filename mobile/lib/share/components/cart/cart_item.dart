import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/share/data/models/cart/cart.dart';

class CartItemWidget extends StatelessWidget {
  final Cart cart;
  final DateTime returnDate;
  final String error;
  final bool isChecked;
  final VoidCallback onDelete;
  final VoidCallback onQuantityDecrease;
  final VoidCallback onQuantityIncrease;
  final VoidCallback onSelectReturnDate;
  final ValueChanged<bool?> onCheckChanged;

  const CartItemWidget({
    super.key,
    required this.cart,
    required this.returnDate,
    required this.error,
    required this.isChecked,
    required this.onDelete,
    required this.onQuantityDecrease,
    required this.onQuantityIncrease,
    required this.onSelectReturnDate,
    required this.onCheckChanged,
  });

  @override
  Widget build(BuildContext context) {
    final book = cart.book;
    final quantity = cart.pivot?.quantity ?? 1;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Info Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox
              _buildCheckbox(),
              SizedBox(width: 8.w),

              // Book Image
              _buildBookImage(book.image),
              SizedBox(width: 12.w),

              // Book Details
              Expanded(child: _buildBookDetails(book)),

              // Delete Button
              _buildDeleteButton(),
            ],
          ),

          SizedBox(height: 12.h),
          Divider(height: 1, color: Colors.grey[200]),
          SizedBox(height: 12.h),

          // Quantity and Return Date Section
          Row(
            children: [
              // Quantity Input
              Expanded(
                child: _buildQuantityInput(quantity, book.quantity ?? 0),
              ),

              SizedBox(width: 12.w),

              // Return Date Input
              Expanded(child: _buildReturnDateInput()),
            ],
          ),

          // Error Message
          if (error.isNotEmpty) _buildErrorMessage(),
        ],
      ),
    );
  }

  /// Build checkbox
  ///
  /// @return Widget
  Widget _buildCheckbox() {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Transform.scale(
        scale: 1.2,
        child: Checkbox(
          value: isChecked,
          onChanged: onCheckChanged,
          activeColor: const Color(0xFFFF6E38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }

  /// Build book image with error fallback
  ///
  /// @param String image - Image path
  ///
  /// @return Widget
  Widget _buildBookImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Image.network(
        '${AppConstants.BASE_URL_IMAGE}$image',
        width: 80.w,
        height: 100.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 80.w,
            height: 100.h,
            color: Colors.grey[200],
            child: Icon(
              Icons.image_not_supported,
              size: 40.sp,
              color: Colors.grey[400],
            ),
          );
        },
      ),
    );
  }

  /// Build book details (name, author, quantity)
  ///
  /// @param Book book - Book data
  ///
  /// @return Widget
  Widget _buildBookDetails(book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.name,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        if (book.author != null)
          Text(
            'Tác giả: ${book.author!.name}',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        SizedBox(height: 4.h),
        Text(
          'Còn lại: ${book.quantity ?? 0} cuốn',
          style: TextStyle(
            fontSize: 12.sp,
            color: book.quantity != null && book.quantity! > 0
                ? Colors.green[600]
                : Colors.red[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Build delete button
  ///
  /// @return Widget
  Widget _buildDeleteButton() {
    return IconButton(
      onPressed: onDelete,
      icon: Icon(Icons.delete_outline, color: Colors.red[400], size: 24.sp),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  /// Build quantity input with +/- buttons
  ///
  /// @param int quantity - Current quantity
  /// @param int maxQuantity - Maximum available quantity
  ///
  /// @return Widget
  Widget _buildQuantityInput(int quantity, int maxQuantity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Số lượng',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Minus Button
              InkWell(
                onTap: quantity > 1 ? onQuantityDecrease : null,
                child: Container(
                  width: 36.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.remove,
                    size: 18.sp,
                    color: quantity > 1 ? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
              ),

              // Quantity Display
              Container(
                width: 50.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.grey[300]!),
                    right: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                child: Text(
                  '$quantity',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Plus Button
              InkWell(
                onTap: quantity < maxQuantity ? onQuantityIncrease : null,
                child: Container(
                  width: 36.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add,
                    size: 18.sp,
                    color: quantity < maxQuantity
                        ? Colors.grey[600]
                        : Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build return date input with calendar icon
  ///
  /// @return Widget
  Widget _buildReturnDateInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ngày trả',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 6.h),
        InkWell(
          onTap: onSelectReturnDate,
          child: Container(
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: error.isNotEmpty ? Colors.red : Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(returnDate),
                  style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                ),
                Icon(
                  Icons.calendar_today,
                  size: 16.sp,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Build error message
  ///
  /// @return Widget
  Widget _buildErrorMessage() {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        error,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.red[600],
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
