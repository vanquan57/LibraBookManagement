import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/features/order/presentation/provider/address_details.provider.dart';
import 'package:mobile/features/order/presentation/provider/order_details_provider.dart';
import 'package:mobile/share/components/order/order_details/order_details_item.dart';
import 'package:mobile/share/components/styled_dialog.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  final int orderId;

  const OrderDetails({super.key, required this.orderId});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String _fullAddress = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Initialize data
  ///
  /// @return void
  void _initializeData() async {
    if (!mounted) return;

    final orderProvider = context.read<OrderDetailsProvider>();
    final addressProvider = context.read<AddressDetailsProvider>();

    // Get order details first
    await orderProvider.getOrdersDetails(widget.orderId);

    // Load full address
    if (orderProvider.orderDetails != null) {
      final order = orderProvider.orderDetails!;

      _fullAddress = await addressProvider.getFullAddress(
        provinceId: order.provinceId,
        districtId: order.districtId,
        wardId: order.wardId,
        address: order.address,
      );

      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetailsProvider>(
      builder: (context, provider, child) {
        _showOrderDetailsDialog(provider);

        if (provider.isLoading && provider.orderDetails == null) {
          return Container(
            width: double.infinity,
            color: const Color(0xFFF5F5F5),
            padding: EdgeInsets.symmetric(vertical: 100.h),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final order = provider.orderDetails;

        if (order == null) {
          return Container(
            width: double.infinity,
            color: const Color(0xFFF5F5F5),
            padding: EdgeInsets.symmetric(vertical: 100.h),
            child: const Center(child: Text('Không có dữ liệu')),
          );
        }

        return Container(
          width: double.infinity,
          color: const Color(0xFFF5F5F5),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Page Title
                Text(
                  'Chi tiết đơn mượn',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),

                // Order Information Card
                _buildOrderInfoCard(order),
                SizedBox(height: 16.h),

                // Order Details Title
                Text(
                  'Danh sách sách',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12.h),

                // Order Details List
                if (order.orderDetails != null &&
                    order.orderDetails!.isNotEmpty)
                  ...order.orderDetails!.map((orderDetail) {
                    return OrderDetailsItem(
                      orderDetail: orderDetail,
                      onStatusChanged: (status, note) {
                        _handleStatusUpdate(
                          provider,
                          orderDetail.pivotOrderBooks!.bookId,
                          status,
                          note,
                        );
                      },
                    );
                  }).toList()
                else
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.h),
                      child: Text(
                        'Không có sách nào trong đơn mượn',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Build order information card
  ///
  /// @param Order order
  ///
  /// @return Widget
  Widget _buildOrderInfoCard(order) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
          // Title
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                size: 24.sp,
                color: const Color(0xFFFF6E38),
              ),
              SizedBox(width: 8.w),
              Text(
                'Thông tin đơn mượn',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF6E38),
                ),
              ),
            ],
          ),
          Divider(height: 24.h, color: Colors.grey[300]),

          // Order Code
          _buildInfoItem('Mã đơn:', order.code),
          SizedBox(height: 10.h),

          // User Name
          _buildInfoItem('Người mượn:', order.user?.name ?? 'N/A'),
          SizedBox(height: 10.h),

          // Phone
          _buildInfoItem('Số điện thoại:', order.phone),
          SizedBox(height: 10.h),

          // Address
          _buildInfoItem('Địa chỉ:', _fullAddress),
          SizedBox(height: 10.h),

          // Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120.w,
                child: Text(
                  'Trạng thái:',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusBackgroundColor(order.status),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    AppConstants.ORDER_STATUS[order.status] ?? 'N/A',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: _getStatusTextColor(order.status),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build info item
  ///
  /// @param String label
  /// @param String value
  ///
  /// @return Widget
  Widget _buildInfoItem(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  /// Get status background color
  ///
  /// @param int status
  ///
  /// @return Color
  Color _getStatusBackgroundColor(int status) {
    switch (status) {
      case 1: // OVERDUE
        return Colors.red.withOpacity(0.1);
      case 2: // BORROWING
        return Colors.blue.withOpacity(0.1);
      case 3: // MISSING
        return Colors.orange.withOpacity(0.1);
      case 4: // RETURNED
        return Colors.green.withOpacity(0.1);
      default:
        return Colors.grey.withOpacity(0.1);
    }
  }

  /// Get status text color
  ///
  /// @param int status
  ///
  /// @return Color
  Color _getStatusTextColor(int status) {
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
        return Colors.grey;
    }
  }

  /// Handle status update
  ///
  /// @param OrderDetailsProvider provider
  /// @param int bookId
  /// @param int status
  /// @param String? note
  ///
  /// @return void
  void _handleStatusUpdate(
    OrderDetailsProvider provider,
    int bookId,
    int status,
    String? note,
  ) async {
    await provider.updateOrderDetailStatus(
      orderId: widget.orderId,
      bookId: bookId,
      status: status,
      note: note,
    );
  }

  /// Show Order Details submission result dialog
  ///
  /// @param {OrderDetailsProvider} orderDetailsProvider
  ///
  /// @return {void}
  void _showOrderDetailsDialog(OrderDetailsProvider orderDetailsProvider) {
    if (orderDetailsProvider.isShowDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (orderDetailsProvider.message != null) {
          if (!mounted) return;

          final successMessage = orderDetailsProvider.message!;

          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) =>
                StyledDialog(message: successMessage, isSuccess: true),
          );
        } else if (orderDetailsProvider.errorMessage != null) {
          // Error case
          if (!mounted) return;

          final errorMessage = orderDetailsProvider.errorMessage!;

          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) =>
                StyledDialog(message: errorMessage, isSuccess: false),
          );
        }

        orderDetailsProvider.resetDialogState();
      });
    }
  }
}
