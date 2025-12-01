import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/core/utils/validators.dart';
import 'package:mobile/features/cart/presentation/provider/cart_provider.dart';
import 'package:mobile/features/checkout/presentation/provider/checkout_provider.dart';
import 'package:mobile/share/components/styled_dialog.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _employeeCodeController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  // Selected values for dropdowns (storing IDs)
  int? _selectedProvinceId;
  int? _selectedDistrictId;
  int? _selectedWardId;

  // Lists for dropdowns
  List<Map<String, dynamic>> _districts = [];
  List<Map<String, dynamic>> _wards = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _employeeCodeController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  /// Initialize data (fetch user profile, provinces, etc.)
  ///
  /// @return void
  void _initializeData() async {
    if (!mounted) return;

    final checkoutProvider = context.read<CheckoutProvider>();
    final cartProvider = context.read<CartProvider>();

    if (cartProvider.cartCheckoutData.isEmpty) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => StyledDialog(
          message: 'Vui lòng cập nhật giỏ mượn để tiến hành mượn sách',
          isSuccess: false,
        ),
      );

      await Future.delayed(const Duration(seconds: 2));
      context.go(AppRouter.cart);
    }
    // Fetch provinces
    await checkoutProvider.getProvinces();

    // Fetch user profile
    await checkoutProvider.getInformationUser();

    if (mounted && checkoutProvider.userProfile != null) {
      final profile = checkoutProvider.userProfile!;

      setState(() {
        _nameController.text = profile['name'] ?? '';
        _employeeCodeController.text = profile['code'] ?? '';
        _emailController.text = profile['email'] ?? '';
        _phoneController.text = profile['phone'] ?? '';
        _districts = [];
        _wards = [];
        _selectedProvinceId = null;
        _selectedDistrictId = null;
        _selectedWardId = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, CheckoutProvider>(
      builder: (context, cartProvider, checkoutProvider, _) {
        final cartCheckoutData = cartProvider.cartCheckoutData;

        return Container(
          width: double.infinity,
          color: const Color(0xFFF5F5F5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                _buildHeader(),

                SizedBox(height: 16.h),

                // Main Content (Form + Cart Items)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      // User Information Form
                      _buildUserInformationForm(checkoutProvider),
                      SizedBox(height: 16.h),

                      // Cart Items Section
                      _buildCartItemsSection(cartCheckoutData),
                      SizedBox(height: 16.h),

                      // Submit Button
                      _buildSubmitButton(cartCheckoutData),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Build header section
  ///
  /// @return Widget
  Widget _buildHeader() {
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
      child: Row(
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 24.sp,
            color: const Color(0xFFFF6E38),
          ),
          SizedBox(width: 12.w),
          Text(
            'Mượn sách',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// Build user information form
  ///
  /// @param CheckoutProvider checkoutProvider
  ///
  /// @return Widget
  Widget _buildUserInformationForm(CheckoutProvider checkoutProvider) {
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin người mượn',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),

            // Name Field (Disabled)
            _buildTextField(
              label: 'Họ tên',
              controller: _nameController,
              enabled: false,
              validator: Validators.fullName,
            ),
            SizedBox(height: 12.h),

            // Employee Code Field (Disabled)
            _buildTextField(
              label: 'Mã sinh viên',
              controller: _employeeCodeController,
              enabled: false,
              validator: Validators.studentCode,
            ),
            SizedBox(height: 12.h),

            // Email Field (Disabled)
            _buildTextField(
              label: 'Email',
              controller: _emailController,
              enabled: false,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
            ),
            SizedBox(height: 12.h),

            // Phone Field
            _buildTextField(
              label: 'Số điện thoại',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              validator: Validators.phone,
            ),
            SizedBox(height: 12.h),

            // Province Dropdown
            _buildDropdownField(
              label: 'Tỉnh thành',
              value: _selectedProvinceId,
              items: checkoutProvider.provinces
                  .map(
                    (province) => {
                      'id': province.id,
                      'name': province.name,
                      'code': province.code,
                    },
                  )
                  .toList(),
              onChanged: (value) async {
                setState(() {
                  _selectedProvinceId = value;
                  _selectedDistrictId = null;
                  _selectedWardId = null;
                  _districts = [];
                  _wards = [];
                });

                if (value != null) {
                  // Find province by ID and get its code
                  final selectedProvince = checkoutProvider.provinces
                      .firstWhere((province) => province.id == value);

                  if (selectedProvince.code != null) {
                    await checkoutProvider.getDistricts(selectedProvince.code!);

                    setState(() {
                      _districts = checkoutProvider.districts
                          .map(
                            (district) => {
                              'id': district.id,
                              'name': district.name,
                              'code': district.code,
                            },
                          )
                          .toList();
                    });
                  }
                }
              },
              validator: (value) => Validators.dropdown(value, 'tỉnh thành'),
            ),
            SizedBox(height: 12.h),

            // District Dropdown
            _buildDropdownField(
              label: 'Quận huyện',
              value: _selectedDistrictId,
              items: _districts,
              onChanged: (value) async {
                setState(() {
                  _selectedDistrictId = value;
                  _selectedWardId = null;
                  _wards = [];
                });

                if (value != null) {
                  // Find district by ID and get its code
                  final selectedDistrict = _districts.firstWhere(
                    (district) => district['id'] == value,
                  );
                  final districtCode = selectedDistrict['code'] as String?;

                  if (districtCode != null) {
                    await checkoutProvider.getWards(districtCode);

                    setState(() {
                      _wards = checkoutProvider.wards
                          .map(
                            (ward) => {
                              'id': ward.id,
                              'name': ward.name,
                              'code': ward.code,
                            },
                          )
                          .toList();
                    });
                  }
                }
              },
              validator: (value) => Validators.dropdown(value, 'quận huyện'),
            ),
            SizedBox(height: 12.h),

            // Ward Dropdown
            _buildDropdownField(
              label: 'Xã phường',
              value: _selectedWardId,
              items: _wards,
              onChanged: (value) {
                setState(() {
                  _selectedWardId = value;
                });
              },
              validator: (value) => Validators.dropdown(value, 'xã phường'),
            ),
            SizedBox(height: 12.h),

            // Address Field
            _buildTextField(
              label: 'Địa chỉ',
              controller: _addressController,
              maxLines: 2,
              validator: Validators.address,
            ),
          ],
        ),
      ),
    );
  }

  /// Build text field
  ///
  /// @param String label
  /// @param TextEditingController controller
  /// @param bool enabled
  /// @param TextInputType keyboardType
  /// @param int maxLines
  /// @param String? Function(String?)? validator
  ///
  /// @return Widget
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            children: [
              if (validator != null)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          key: ValueKey(controller.text),
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            fontSize: 14.sp,
            color: enabled ? Colors.black87 : Colors.black54,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey[100],
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
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
              borderSide: const BorderSide(color: Color(0xFFFF6E38)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  /// Build dropdown field
  ///
  /// @param String label
  /// @param int? value
  /// @param List<Map<String, dynamic>> items
  /// @param void Function(int?)? onChanged
  /// @param String? Function(int?)? validator
  ///
  /// @return Widget
  Widget _buildDropdownField({
    required String label,
    required int? value,
    required List<Map<String, dynamic>> items,
    required void Function(int?)? onChanged,
    String? Function(int?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            children: [
              if (validator != null)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        DropdownButtonFormField<int>(
          value: value,
          validator: validator,
          dropdownColor: Colors.white,
          menuMaxHeight: 300.h,
          isExpanded: true,
          style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
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
              borderSide: const BorderSide(color: Color(0xFFFF6E38)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          hint: Text(
            'Chọn $label',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          items: items.map((item) {
            return DropdownMenuItem<int>(
              value: item['id'] as int,
              child: Text(
                item['name'] as String,
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  /// Build cart items section
  ///
  /// @param List<Map<String, dynamic>> cartCheckoutData
  ///
  /// @return Widget
  Widget _buildCartItemsSection(List<Map<String, dynamic>> cartCheckoutData) {
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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sách',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Số lượng',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Ngày trả',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(height: 1, color: Colors.grey[200]),
          SizedBox(height: 12.h),

          // Cart Items List
          if (cartCheckoutData.isEmpty)
            _buildEmptyCart()
          else
            ...cartCheckoutData.map((item) => _buildCheckoutCartItem(item)),

          if (cartCheckoutData.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Divider(height: 1, color: Colors.grey[200]),
            SizedBox(height: 12.h),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng cộng',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6E38).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${_calculateTotalQuantity(cartCheckoutData)} cuốn',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF6E38),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Build empty cart message
  ///
  /// @return Widget
  Widget _buildEmptyCart() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 60.sp,
              color: Colors.grey[300],
            ),
            SizedBox(height: 12.h),
            Text(
              'Chưa có sách được chọn',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  /// Build checkout cart item (view-only, no interactions)
  ///
  /// @param Map<String, dynamic> item
  ///
  /// @return Widget
  Widget _buildCheckoutCartItem(Map<String, dynamic> item) {
    final bookName = item['name'] as String? ?? '';
    final image = item['image'] as String? ?? '';
    final quantity = item['quantity'] as int? ?? 0;
    final returnDate = item['return_date'] as String? ?? '';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Image
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: Image.network(
              '${AppConstants.BASE_URL_IMAGE}$image',
              width: 60.w,
              height: 75.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60.w,
                  height: 75.h,
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.image_not_supported,
                    size: 30.sp,
                    color: Colors.grey[400],
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 12.w),

          // Book Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        'SL: $quantity',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    // Return Date
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 12.sp,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            returnDate,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build submit button
  ///
  /// @param List<Map<String, dynamic>> cartCheckoutData
  ///
  /// @return Widget
  Widget _buildSubmitButton(List<Map<String, dynamic>> cartCheckoutData) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: cartCheckoutData.isEmpty
            ? () => context.push(AppRouter.cart)
            : () => _handleSubmit(cartCheckoutData),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6E38),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey[300],
          disabledForegroundColor: Colors.grey[600],
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 2,
        ),
        child: Text(
          'Xác nhận đơn mượn',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// Calculate total quantity
  ///
  /// @param List<Map<String, dynamic>> cartCheckoutData
  ///
  /// @return int
  int _calculateTotalQuantity(List<Map<String, dynamic>> cartCheckoutData) {
    return cartCheckoutData.fold<int>(
      0,
      (sum, item) => sum + ((item['quantity'] as int?) ?? 0),
    );
  }

  /// Handle form submission
  ///
  /// @return void
  void _handleSubmit(List<Map<String, dynamic>> cartCheckoutData) async {
    final checkoutProvider = context.read<CheckoutProvider>();
    final cartProvider = context.read<CartProvider>();

    if (_formKey.currentState!.validate()) {
      final formData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'province_id': _selectedProvinceId,
        'district_id': _selectedDistrictId,
        'ward_id': _selectedWardId,
        'address': _addressController.text,
        'orderDetails': cartCheckoutData
            .map(
              (item) => {
                'book_id': item['book_id'],
                'quantity': item['quantity'],
                'return_date': item['return_date'],
              },
            )
            .toList(),
      };

      await checkoutProvider.submit(formData);

      if (checkoutProvider.message != null && checkoutProvider.isShowDialog) {
        if (!mounted) return;
        final message = checkoutProvider.message!;

        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => StyledDialog(
            message: message,
            isSuccess: true,
          ),
        );

        cartProvider.cartCheckoutData = [];
        context.go(AppRouter.order);
      } else if (checkoutProvider.errorMessage != null && checkoutProvider.isShowDialog) {
        if (!mounted) return;
        final errorMessage = checkoutProvider.errorMessage!;
        
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => StyledDialog(
            message: errorMessage,
            isSuccess: false,
          ),
        );
      }

      checkoutProvider.resetDialogState();
    }
  }
}
