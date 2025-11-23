// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/di/injection.dart';
import 'package:mobile/core/helper/protected_route.dart';
import 'package:mobile/features/home/presentation/provider/home_provider.dart';
import 'package:mobile/features/wishlist/presentation/provider/wishlist_provider.dart';
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
        providerFactory: () =>
            ChangeNotifierProvider(create: (_) => getIt<WishlistProvider>()),
      ),
    ],

    // Error page
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found'))),
  );
}
