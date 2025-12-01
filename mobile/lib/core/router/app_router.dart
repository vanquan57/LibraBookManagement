// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/di/injection.dart';
import 'package:mobile/core/helper/protected_route.dart';
import 'package:mobile/features/auth/presentation/provider/change_password_provider.dart';
import 'package:mobile/features/auth/presentation/screens/change_password.dart';
import 'package:mobile/features/book_details/presentation/provider/book_details_provider.dart';
import 'package:mobile/features/book_details/presentation/screens/book_details.dart';
import 'package:mobile/features/cart/presentation/screens/cart.dart';
import 'package:mobile/features/checkout/presentation/provider/checkout_provider.dart';
import 'package:mobile/features/checkout/presentation/screens/checkout.dart';
import 'package:mobile/features/contact%20copy/presentation/provider/about_provider.dart';
import 'package:mobile/features/contact%20copy/presentation/screens/about.dart';
import 'package:mobile/features/contact/presentation/provider/contact_provider.dart';
import 'package:mobile/features/contact/presentation/screens/contact.dart';
import 'package:mobile/features/home/presentation/provider/home_provider.dart';
import 'package:mobile/features/list_book/presentation/provider/list_book_provider.dart';
import 'package:mobile/features/list_book/presentation/screens/list_book.dart';
import 'package:mobile/features/order/presentation/provider/address_details.provider.dart';
import 'package:mobile/features/order/presentation/provider/order_details_provider.dart';
import 'package:mobile/features/order/presentation/provider/order_provider.dart';
import 'package:mobile/features/order/presentation/screens/order.dart';
import 'package:mobile/features/order/presentation/screens/order_details.dart';
import 'package:mobile/features/profile/presentation/provider/profile_provider.dart';
import 'package:mobile/features/profile/presentation/screens/profile.dart';
import 'package:mobile/features/wishlist/presentation/screens/wishlist.dart';
import 'package:mobile/share/components/layouts/main_layout.dart';
import 'package:mobile/features/auth/presentation/screens/login_signup_switcher.dart';
import 'package:mobile/features/home/presentation/screens/home.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static const String splash = '/';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String wishlist = '/wishlist';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String listBook = '/list_book';
  static const String bookDetails = '/book_details';
  static const String profile = '/profile';
  static const String changePassword = '/change_password';
  static const String contact = '/contact';
  static const String about = '/about';
  static const String order = '/order';
  static const String orderDetails = '/order_details';
  
  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: home, // ✅ Screen default
    debugLogDiagnostics: true, // Debug mode

    redirect: (BuildContext context, GoRouterState state) {
      // TODO: Check if user is logged in
      // final isLoggedIn = ... get from storage or provider
      // if (!isLoggedIn && state.location != auth) {
      //   return auth;
      // }
      return null; // No redirect
    },

    routes: [
      // Auth route (Login/Signup)
      GoRoute(
        path: auth,
        name: 'auth',
        builder: (context, state) => const LoginSignupSwitcher(),
      ),
      // Home route
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) {
          return ChangeNotifierProvider<HomeProvider>(
            create: (_) => getIt<HomeProvider>(),
            child: MainLayout(child: const HomePage()),
          );
        },
      ),
      // Wishlist route
      protectedRoute(
        path: AppRouter.wishlist,
        pathLogin: AppRouter.auth,
        child: MainLayout(child: const Wishlist()),
      ),
      // Cart route
      protectedRoute(
        path: AppRouter.cart,
        pathLogin: AppRouter.auth,
        child: MainLayout(child: const CartScreen()),
      ),
      // Checkout route
      protectedRoute(
        path: AppRouter.checkout,     
        pathLogin: AppRouter.auth,
        providerFactory: () => [
          ChangeNotifierProvider<CheckoutProvider>(
            create: (_) => getIt<CheckoutProvider>(),
          ),
        ],
        child: MainLayout(child: const CheckoutScreen()),
      ),
      // List book
      GoRoute(
        path: listBook,
        name: 'list_book',
        builder: (context, state) {
          return ChangeNotifierProvider<ListBookProvider>(
            create: (_) => getIt<ListBookProvider>(),
            child: const ListBookScreen(),
          );
        },
      ),
      // Book details route
      GoRoute(
        path: '$bookDetails/:id',
        name: 'book_details', 
        builder: (context, state) {
          final bookId = state.pathParameters['id']!;

          return ChangeNotifierProvider<BookDetailsProvider>(
            create: (_) => getIt<BookDetailsProvider>(),
            child: MainLayout(child: BookDetails(bookId: int.parse(bookId))),
          );
        },
      ),
            // Checkout route
      protectedRoute(
        path: AppRouter.profile,     
        pathLogin: AppRouter.auth,
        providerFactory: () => [
          ChangeNotifierProvider<ProfileProvider>(
            create: (_) => getIt<ProfileProvider>(),
          ),
        ],
        child: MainLayout(child: const Profile()),
      ),
      // Change password route
      protectedRoute(
        path: AppRouter.changePassword,     
        pathLogin: AppRouter.auth,
        providerFactory: () => [
          ChangeNotifierProvider<ChangePasswordProvider>(
            create: (_) => getIt<ChangePasswordProvider>(),
          ),
        ],
        child: MainLayout(child: const ChangePassword()),
      ),
      // Book details route
      GoRoute(
        path: contact,
        name: 'contact', 
        builder: (context, state) {
          return ChangeNotifierProvider<ContactProvider>(
            create: (_) => getIt<ContactProvider>(),
            child: MainLayout(child: const Contact()),
          );
        },
      ),
      // About route
      GoRoute(
        path: about,
        name: 'about', 
        builder: (context, state) {
          return ChangeNotifierProvider<AboutProvider>(
            create: (_) => getIt<AboutProvider>(),
            child: MainLayout(child: const About()),
          );
        },
      ),
      // Order route
      protectedRoute(
        path: AppRouter.order,     
        pathLogin: AppRouter.auth,
        providerFactory: () => [
          ChangeNotifierProvider<OrderProvider>(
            create: (_) => getIt<OrderProvider>(),
          ),
        ],
        child: MainLayout(child: const Order()),
      ),
      // Order details route
      protectedRoute(
        path: '${AppRouter.orderDetails}/:id',
        pathLogin: AppRouter.auth,
        providerFactory: () => [
          ChangeNotifierProvider<OrderDetailsProvider>(
            create: (_) => getIt<OrderDetailsProvider>(),
          ),
          ChangeNotifierProvider<AddressDetailsProvider>(
            create: (_) => getIt<AddressDetailsProvider>(),
          ),
        ],
        builder: (context, state) {
          final orderId = state.pathParameters['id']!;

          return MainLayout(
            child: OrderDetails(orderId: int.parse(orderId)),
          );
        },
      ),
    ],

    // Error page
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found'))),
  );
}
