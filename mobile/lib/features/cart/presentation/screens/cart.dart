import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/helper/format_date.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/cart/presentation/provider/cart_provider.dart';
import 'package:mobile/share/components/cart/cart_item.dart';
import 'package:mobile/share/components/styled_dialog.dart';
import 'package:mobile/share/data/models/cart/cart.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/helper/protected_route.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Store return dates for each cart item (book_id -> date)
  final Map<int, DateTime> _returnDates = {};

  // Store validation errors for each cart item
  final Map<int, String> _errors = {};

  // Store checked state for each cart item (book_id -> isChecked)
  final Map<int, bool> _checkedItems = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _refreshCart();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshCart();
  }

  /// Refresh cart data
  ///
  /// @return void
  void _refreshCart() {
    Future.microtask(() {
      context.read<CartProvider>().getCart();

      // Initialize return dates to current date for all items
      final carts = context.read<CartProvider>().carts;

      for (var cart in carts) {
        if (!_returnDates.containsKey(cart.book.id)) {
          _returnDates[cart.book.id] = DateTime.now();
          _errors[cart.book.id] = '';
          _checkedItems[cart.book.id] = true; // Default checked
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        final List<Cart> carts = cartProvider.carts;
        _showCartDialog(cartProvider);

        return Container(
          width: double.infinity,
          color: const Color(0xFFF5F5F5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Section
              _buildHeader(carts.length),

              SizedBox(height: 8.h),

              // Cart Items List
              carts.isEmpty ? _buildEmptyCart() : _buildCartList(carts),

              // Footer with Total and Actions
              if (carts.isNotEmpty) _buildFooter(carts),
            ],
          ),
        );
      },
    );
  }

  /// Build header section
  ///
  /// @param int itemCount - Number of items in cart
  ///
  /// @return Widget
  Widget _buildHeader(int itemCount) {
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
            Icons.shopping_cart_outlined,
            size: 24.sp,
            color: const Color(0xFFFF6E38),
          ),
          SizedBox(width: 12.w),
          Text(
            'Giỏ mượn',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 8.w),
          if (itemCount > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6E38),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '$itemCount',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Build empty cart message
  ///
  /// @return Widget
  Widget _buildEmptyCart() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100.sp,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16.h),
          Text(
            'Giỏ mượn trống',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Hãy thêm sách vào giỏ mượn của bạn',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              context.go(AppRouter.home);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6E38),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Khám phá sách',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  /// Build cart items list
  ///
  /// @param List<Cart> carts - List of cart items
  ///
  /// @return Widget
  Widget _buildCartList(List<Cart> carts) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: carts.length,
      itemBuilder: (context, index) {
        final cart = carts[index];
        return _buildCartItem(cart);
      },
    );
  }

  /// Build individual cart item card
  ///
  /// @param Cart cart - Cart item data
  ///
  /// @return Widget
  Widget _buildCartItem(Cart cart) {
    final book = cart.book;
    final returnDate = _returnDates[book.id] ?? DateTime.now();
    final error = _errors[book.id] ?? '';
    final isChecked = _checkedItems[book.id] ?? true;

    return CartItemWidget(
      cart: cart,
      returnDate: returnDate,
      error: error,
      isChecked: isChecked,
      onDelete: () async {
        if (await ensureLogin(context)) {
          context.read<CartProvider>().removeFromCart(book.id);
        }
      },
      onQuantityDecrease: () async {
        final quantity = cart.pivot?.quantity ?? 1;

        if (quantity > 1 && await ensureLogin(context)) {
          updateQuantity(book.id, quantity - 1);
        }
      },
      onQuantityIncrease: () async {
        final quantity = cart.pivot?.quantity ?? 1;

        if (quantity < (book.quantity ?? 0) && await ensureLogin(context)) {
          updateQuantity(book.id, quantity + 1);
        }
      },
      onSelectReturnDate: () {
        _selectReturnDate(context, book.id, returnDate);
      },
      onCheckChanged: (bool? value) {
        setState(() {
          _checkedItems[book.id] = value ?? false;
        });
      },
    );
  }

  /// Build footer with total and action buttons
  ///
  /// @param List<Cart> carts - List of cart items
  ///
  /// @return Widget
  Widget _buildFooter(List<Cart> carts) {
    // Calculate total quantity for checked items only
    final totalQuantity = carts.fold<int>(
      0,
      (sum, cart) {
        final isChecked = _checkedItems[cart.book.id] ?? true;
        return sum + (isChecked ? (cart.pivot?.quantity ?? 0) : 0);
      },
    );

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Total Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng số lượng:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6E38).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '$totalQuantity cuốn',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF6E38),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _updateCartCheckoutData(carts);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDB4444),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: 2,
              ),
              child: Text(
                'Tiến hành mượn sách',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  /// Select return date using date picker
  ///
  /// @param BuildContext context
  /// @param int bookId - Book ID
  /// @param DateTime currentDate - Current selected date
  ///
  /// @return Future<void>
  Future<void> _selectReturnDate(
    BuildContext context,
    int bookId,
    DateTime currentDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF6E38),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != currentDate) {
      setState(() {
        _returnDates[bookId] = picked;

        // Validate return date
        if (picked.isBefore(DateTime.now())) {
          _errors[bookId] = 'Ngày trả không thể nhỏ hơn ngày hiện tại';
        } else {
          _errors[bookId] = '';
        }
      });
    }
  }

  /// Update quantity of a book in cart
  ///
  /// @param int bookId - Book ID
  /// @param int quantity - New quantity
  ///
  /// @return void
  void updateQuantity(int bookId, int quantity) {
    List<Map<String, dynamic>> carts = [];
    carts.add({'book_id': bookId, 'quantity': quantity});

    context.read<CartProvider>().updateCart(carts);
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
            message: cartProvider.message,
            isSuccess: cartProvider.isSuccess,
          ),
        );
      });
    }
  }

  /// Update cart checkout data
  /// 
  /// @param List<Cart> carts
  /// 
  /// @return void
  void _updateCartCheckoutData(List<Cart> carts) {
    // Filter only checked items
    final checkedCarts = carts.where((cart) {
      return _checkedItems[cart.book.id] ?? false;
    }).toList();

    // Check if no items are selected
    if (checkedCarts.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => StyledDialog(
          message: 'Vui lòng chọn ít nhất một sách để mượn',
          isSuccess: false,
        ),
      );
      return;
    }

    // Check for errors in checked items
    final hasErrors = checkedCarts.any((cart) {
      final error = _errors[cart.book.id] ?? '';
      return error.isNotEmpty;
    });

    if (hasErrors) {
      return;
    }

    final List<Map<String, dynamic>> data = checkedCarts.map((cart) {
      return {
        'book_id': cart.book.id,
        'name': cart.book.name,
        'image': cart.book.image,
        'quantity': cart.pivot?.quantity ?? 1,
        'return_date': formatDay(_returnDates[cart.book.id]!),
      };
    }).toList();

    context.read<CartProvider>().cartCheckoutData = data;

    context.go(AppRouter.checkout);
  }
}
