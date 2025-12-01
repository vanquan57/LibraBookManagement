import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/cart/presentation/provider/cart_provider.dart';
import 'package:mobile/features/list_book/presentation/provider/list_book_provider.dart';
import 'package:mobile/features/wishlist/presentation/provider/wishlist_provider.dart';
import 'package:mobile/share/provider/global/header_provider.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(185);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String _selectedLanguage = 'English';
  final GlobalKey _personIconKey = GlobalKey();
  final querySearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String currentLocation = GoRouterState.of(context).uri.toString();
    final wishlistProvider = context.watch<WishlistProvider>();
    final headerProvider = context.watch<HeaderProvider>();

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.deepOrange,
      elevation: 0,
      toolbarHeight: 185.h,
      flexibleSpace: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'VKU - Trao tri thức, nhận thành công: ',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          TextSpan(
                            text: ', đọc sách hôm nay, thành công mai sau.',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          TextSpan(
                            text: 'Mượn Sách Miễn Phí tại VKU Library',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedLanguage,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        dropdownColor: Colors.deepOrange.shade400,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                        },
                        items: <String>['English', 'Tiếng Việt', '中文', '日本語']
                            .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            })
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    const Text(
                      'VKU-Libra',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildNavItem('Trang Chủ', '/home', currentLocation),
                        const SizedBox(width: 20),
                        _buildNavItem('Liên Hệ', AppRouter.contact, currentLocation),
                        const SizedBox(width: 20),
                        _buildNavItem('Giới Thiệu', AppRouter.about, currentLocation),
                        const SizedBox(width: 20),
                        _buildNavItem('Đăng Ký', '/auth', currentLocation),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          if (currentLocation == AppRouter.listBook)
                            IconButton(
                              onPressed: () => _handleMenuClick(context, currentLocation),
                              icon: const Icon(Icons.menu),
                            ),
                          Expanded(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: querySearchController,
                                      decoration: InputDecoration(
                                        hintText: 'Tìm kiếm sách',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.search),
                                      onPressed: () {
                                        headerProvider.setQuerySearch(querySearchController.text.trim());
                                        querySearchController.clear();

                                        if (currentLocation != AppRouter.listBook) {
                                          context.push(AppRouter.listBook);
                                        }
                                      },
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Stack(
                            clipBehavior:
                                Clip.none,
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.push(
                                    '/wishlist',
                                  );
                                },
                                icon: const Icon(Icons.favorite_border),
                                color: Colors.black54,
                              ),
                              if (wishlistProvider.wishListIds.isNotEmpty)
                                Positioned(
                                  right: 5,
                                  top: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFF6E38),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '${wishlistProvider.wishListIds.length}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              IconButton(
                                onPressed: () => context.push(AppRouter.cart),
                                icon: const Icon(Icons.shopping_cart_outlined),
                                color: Colors.black54,
                              ),
                              Selector<CartProvider, int>(
                                selector: (_, provider) =>
                                    provider.carts.length,
                                builder: (_, count, __) {
                                  if (count == 0) return SizedBox.shrink();

                                  return Positioned(
                                    right: 5,
                                    top: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 16,
                                        minHeight: 16,
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFF6E38),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '$count',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          IconButton(
                            key: _personIconKey,
                            onPressed: () => _showUserMenu(context),
                            icon: const Icon(Icons.person_outline),
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Handle menu icon click - toggle sidebar on list_book page
  ///
  /// returns: void
  void _handleMenuClick(BuildContext context, String currentLocation) {
      final listBookProvider = context.read<ListBookProvider>();
      listBookProvider.toggleSidebar();
  }

  /// Build individual navigation item with highlighting for the selected page.
  ///
  /// returns: Widget
  Widget _buildNavItem(String title, String route, String currentLocation) {
    final bool isSelected = currentLocation == route;
    return GestureDetector(
      onTap: () {
        if (currentLocation != route) {
          context.push(route);
        }
      },
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.deepOrange : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }

  /// Show user menu when tapping the person icon 'My Account', 'My Orders', 'Wishlist', and 'Logout'.
  ///
  /// returns: void
  void _showUserMenu(BuildContext context) {
    final RenderBox renderBox =
        _personIconKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx - 190,
        position.dy + size.height,
        position.dx + size.width,
        position.dy + size.height,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: const Color(0xFFB8B594),
      items: [
        PopupMenuItem(
          onTap: () => context.push(AppRouter.profile),
          child: Row(
            children: const [
              Icon(Icons.person_outline, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Tài Khoản Của Tôi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () => context.push(AppRouter.order),
          child: Row(
            children: const [
              Icon(Icons.shopping_bag_outlined, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Đơn Mượn Của Tôi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          enabled: false,
          child: Row(
            children: const [
              Icon(Icons.favorite_outline, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Danh Sách Yêu Thích',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          enabled: false,
          child: Row(
            children: const [
              Icon(Icons.logout, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Đăng Xuất',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
