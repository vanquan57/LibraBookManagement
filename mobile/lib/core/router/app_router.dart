// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/di/injection.dart';
import 'package:mobile/core/helper/protected_route.dart';
import 'package:mobile/features/book_details/presentation/provider/book_details_provider.dart';
import 'package:mobile/features/book_details/presentation/screens/book_details.dart';
import 'package:mobile/features/cart/presentation/screens/cart.dart';
import 'package:mobile/features/checkout/presentation/provider/checkout_provider.dart';
import 'package:mobile/features/checkout/presentation/screens/checkout.dart';
import 'package:mobile/features/home/presentation/provider/home_provider.dart';
import 'package:mobile/features/list_book/presentation/provider/list_book_provider.dart';
import 'package:mobile/features/list_book/presentation/screens/list_book.dart';
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
    ],

    // Error page
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found'))),
  );
}
