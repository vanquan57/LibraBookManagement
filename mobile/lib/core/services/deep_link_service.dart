import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';

class DeepLinkService {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> init(GoRouter router) async {
    _appLinks = AppLinks();

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri, router);
    });

    try {
      final uri = await _appLinks.getInitialLink();
      if (uri != null) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _handleDeepLink(uri, router);
        });
      }
    } catch (e) {
      print('Error getting initial link: $e');
    }
  }

  void _handleDeepLink(Uri uri, GoRouter router) {
    print('Deep link received: ${uri.toString()}');
    print('URI path: ${uri.path}');
    print('URI query parameters: ${uri.queryParameters}');
    
    // Normalize path by removing trailing slash for comparison
    final normalizedPath = uri.path.endsWith('/') 
        ? uri.path.substring(0, uri.path.length - 1)
        : uri.path;
    
    // Handle reset password deeplink
    if (normalizedPath == '/auth/password/reset' || 
        normalizedPath.startsWith('/auth/password/reset/')) {
      final token = uri.queryParameters['token'];
      final email = uri.queryParameters['email'];

      print('Token: $token');
      print('Email: $email');

      if (token != null && email != null) {
        // Decode email if it's still encoded
        final decodedEmail = Uri.decodeComponent(email);
        
        // Build URL with query parameters for go()
        final resetPasswordUrl = Uri(
          path: AppRouter.resetPassword,
          queryParameters: {
            'token': token,
            'email': decodedEmail,
          },
        ).toString();
        
        print('Navigating to: $resetPasswordUrl');
        
        // Use go() to navigate to reset password screen
        // Route will read from query parameters
        router.go(resetPasswordUrl);
      } else {
        print('Missing token or email in reset password link');
        print('Token is null: ${token == null}');
        print('Email is null: ${email == null}');
      }
    } else {
      print('Deep link path does not match reset password pattern');
    }
    
    // TODO: Add other deep links here
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}