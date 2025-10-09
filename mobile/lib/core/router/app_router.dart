// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/screens/login_signup_switcher.dart';

class AppRouter {
  static const String splash = '/';
  static const String auth = '/auth';

  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: auth, // ✅ Screen default
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
    ],

    // Error page
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found'))),
  );
}
