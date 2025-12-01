import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/helper/format_date.dart';
import 'package:mobile/share/data/models/order/order_details/order_details.dart';

class OrderDetailsItem extends StatelessWidget {
  final OrderDetails orderDetail;
  final Function(int status, String? note) onStatusChanged;

  const OrderDetailsItem({
    super.key,
    required this.orderDetail,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final book = orderDetail.book;
    final pivot = orderDetail.pivotOrderBooks;

    if (pivot == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Image
          _buildBookImage(book.image),
          SizedBox(width: 15.w),

          // Book Info
          Expanded(child: _buildBookInfo(context, book.name, pivot)),
        ],
      ),
    );
  }

  /// Build book image
  ///
  /// @param String image
  ///
  /// @return Widget
  Widget _buildBookImage(String image) {
    return Container(
      width: 100.w,
      height: 140.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: Image.network(
          '${AppConstants.BASE_URL_IMAGE}$image',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: const Icon(Icons.book, size: 40),
            );
          },
        ),
      ),
    );
  }

  /// Build book info
  ///
  /// @param BuildContext context
  /// @param String bookName
  /// @param PivotOrderBook pivot
  ///
  /// @return Widget
  Widget _buildBookInfo(BuildContext context, String bookName, pivot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Book Name
        Text(
          bookName,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 10.h),

        // Info Grid
        _buildInfoRow('Số lượng:', pivot.quantity.toString()),
        SizedBox(height: 6.h),
        _buildInfoRow('Ngày trả:', formatDateStringDisplay(pivot.returnDate)),
        SizedBox(height: 6.h),
        _buildInfoRow('Ghi chú:', pivot.note ?? 'Không có'),
        SizedBox(height: 10.h),

        // Status Dropdown
        _buildStatusDropdown(context, pivot.status),
      ],
    );
  }

  /// Build info row
  ///
  /// @param String label
  /// @param String value
  ///
  /// @return Widget
  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13.sp, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  /// Build status dropdown
  ///
  /// @param BuildContext context
  /// @param int currentStatus
  ///
  /// @return Widget
  Widget _buildStatusDropdown(BuildContext context, int currentStatus) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Trạng thái:',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: currentStatus,
                isExpanded: true,
                isDense: true,
                dropdownColor: Colors.white,
                icon: Icon(Icons.arrow_drop_down, size: 20.sp),
                style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                items: AppConstants.ORDER_STATUS.entries.map((entry) {
                  return DropdownMenuItem<int>(
                    value: entry.key,
                    enabled: !_isStatusDisabled(entry.key, currentStatus),
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        color: _isStatusDisabled(entry.key, currentStatus)
                            ? Colors.grey
                            : _getStatusColor(entry.key),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (int? newStatus) {
                  if (newStatus != null && newStatus != currentStatus) {
                    _handleStatusChange(context, newStatus);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Check if status should be disabled
  ///
  /// @param int value
  /// @param int currentStatus
  ///
  /// @return bool
  bool _isStatusDisabled(int value, int currentStatus) {
    // Same status is disabled
    if (value == currentStatus) {
      return true;
    }

    // Only MISSING and RETURNED can be selected
    if (value != AppConstants.MISSING && value != AppConstants.RETURNED) {
      return true;
    }

    // If already RETURNED, cannot change
    if (currentStatus == AppConstants.RETURNED) {
      return true;
    }

    return false;
  }

  /// Get status color
  ///
  /// @param int status
  ///
  /// @return Color
  Color _getStatusColor(int status) {
    switch (status) {
      case 1: // OVERDUE
        return Colors.red;
      case 2: // BORROWING
        return Colors.blue;
      case 3: // MISSING
        return Colors.orange;
      case 4: // RETURNED
        return Colors.green;
      default:
        return Colors.black87;
    }
  }

  /// Handle status change
  ///
  /// @param BuildContext context
  /// @param int newStatus
  ///
  /// @return void
  void _handleStatusChange(BuildContext context, int newStatus) async {
    String? note;

    // If status is MISSING, show dialog to input note
    if (newStatus == AppConstants.MISSING) {
      note = await _showNoteDialog(context);
      if (note == null || note.isEmpty) {
        return; // User cancelled or didn't input note
      }
    }

    onStatusChanged(newStatus, note);
  }

  /// Show dialog to input note
  ///
  /// @param BuildContext context
  ///
  /// @return Future<String?>
  Future<String?> _showNoteDialog(BuildContext context) async {
    final TextEditingController noteController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Lý do mất sách'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: noteController,
              autofocus: true,
              maxLength: 255,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Nhập lý do mất sách',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                contentPadding: EdgeInsets.all(12.w),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lý do không được để trống';
                }
                if (value.length > 255) {
                  return 'Lý do không được vượt quá 255 ký tự';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(null);
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(dialogContext).pop(noteController.text.trim());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6E38),
              ),
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }
}
