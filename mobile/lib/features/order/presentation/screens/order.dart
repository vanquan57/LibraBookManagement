import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/helper/format_date.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/core/utils/validators.dart';
import 'package:mobile/features/order/presentation/provider/order_provider.dart';
import 'package:mobile/share/components/order/order/order_item.dart';
import 'package:mobile/share/components/pagination/pagination.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  String? _dateRangeError;

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

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
 

    Future.microtask(() {
      _initializeData();
    });
  }

  /// Initialize data
  ///
  /// @return void
  void _initializeData() async {
    if (!mounted) return;
    await context.read<OrderProvider>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, _) {
        return Container(
          width: double.infinity,
          color: const Color(0xFFF5F5F5),
          child: Column(
            children: [
              // Search Form
              _buildSearchForm(orderProvider),

              // Orders List
              if (orderProvider.isLoading)
                _buildLoadingIndicator()
              else if (orderProvider.ordersList.isEmpty)
                _buildEmptyState()
              else
                _buildOrdersList(orderProvider),

              // Pagination
              if (!orderProvider.isLoading &&
                  orderProvider.ordersList.isNotEmpty)
                Pagination(
                  currentPage: orderProvider.currentPage,
                  totalPages: orderProvider.totalPages,
                  onPageChanged: (page) {
                    orderProvider.changePage(page);
                  },
                ),

              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  /// Build search form
  ///
  /// @param OrderProvider orderProvider
  ///
  /// @return Widget
  Widget _buildSearchForm(OrderProvider orderProvider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tìm kiếm đơn mượn',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),

            // Date pickers row
            Row(
              children: [
                // Start date
                Expanded(
                  child: _buildDateField(
                    label: 'Ngày bắt đầu',
                    selectedDate: orderProvider.startDate,
                    onDateSelected: (date) {
                      orderProvider.setStartDate(date);
                      _validateDateRange(orderProvider);
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                // End date
                Expanded(
                  child: _buildDateField(
                    label: 'Ngày kết thúc',
                    selectedDate: orderProvider.endDate,
                    onDateSelected: (date) {
                      orderProvider.setEndDate(date);
                      _validateDateRange(orderProvider);
                    },
                  ),
                ),
              ],
            ),

            // Date range error
            if (_dateRangeError != null) ...[
              SizedBox(height: 8.h),
              Text(
                _dateRangeError!,
                style: TextStyle(fontSize: 12.sp, color: Colors.red),
              ),
            ],

            SizedBox(height: 12.h),

            // Status dropdown
            _buildStatusDropdown(orderProvider),

            SizedBox(height: 16.h),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_dateRangeError == null) {
                        orderProvider.searchOrders();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Tìm kiếm',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      orderProvider.clearFilters();
                      setState(() {
                        _dateRangeError = null;
                      });
                      orderProvider.getOrders();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Xóa bộ lọc',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build date field
  ///
  /// @param String label
  /// @param DateTime? selectedDate
  /// @param Function(DateTime?) onDateSelected
  ///
  /// @return Widget
  Widget _buildDateField({
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime?) onDateSelected,
  }) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF3B82F6),
                  onPrimary: Colors.white,
                  onSurface: Colors.black87,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 20.sp, color: Colors.grey[600]),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    selectedDate != null
                        ? formatDateDisplay(selectedDate)
                        : 'Chọn ngày',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: selectedDate != null
                          ? Colors.black87
                          : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build status dropdown
  ///
  /// @param OrderProvider orderProvider
  ///
  /// @return Widget
  Widget _buildStatusDropdown(OrderProvider orderProvider) {
    return DropdownButtonFormField<int>(
      value: orderProvider.selectedStatus,
      dropdownColor: Colors.white,
      menuMaxHeight: 300.h,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Trạng thái',
        prefixIcon: Icon(Icons.filter_list, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF3B82F6)),
        ),
      ),
      hint: const Text('Chọn trạng thái'),
      items: AppConstants.ORDER_STATUS.entries.map((entry) {
        return DropdownMenuItem<int>(
          value: entry.key,
          child: Text(
            entry.value,
            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          ),
        );
      }).toList(),
      onChanged: (value) {
        orderProvider.setStatus(value);
      },
    );
  }

  /// Validate date range
  ///
  /// @param OrderProvider orderProvider
  ///
  /// @return void
  void _validateDateRange(OrderProvider orderProvider) {
    setState(() {
      _dateRangeError = Validators.endDate(
        orderProvider.endDate,
        orderProvider.startDate,
      );
    });
  }

  /// Build loading indicator
  ///
  /// @return Widget
  Widget _buildLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: const Center(
        child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
      ),
    );
  }

  /// Build empty state
  ///
  /// @return Widget
  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 100.sp,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16.h),
          Text(
            'Không tìm thấy đơn mượn',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Bạn chưa có đơn mượn nào',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  /// Build orders list
  ///
  /// @param OrderProvider orderProvider
  ///
  /// @return Widget
  Widget _buildOrdersList(OrderProvider orderProvider) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: orderProvider.ordersList.length,
      itemBuilder: (context, index) {
        final order = orderProvider.ordersList[index];
        return OrderItem(
          order: order,
          index:
              index +
              (orderProvider.currentPage - 1) * AppConstants.LIMIT_ORDER,
          onViewDetails: () {
            _showOrderDetails(order);
          },
        );
      },
    );
  }

  /// Show order details
  ///
  /// @param BookOrder order
  ///
  /// @return void
  void _showOrderDetails(dynamic order) {
    context.push('${AppRouter.orderDetails}/${order.id}');
  }

}
