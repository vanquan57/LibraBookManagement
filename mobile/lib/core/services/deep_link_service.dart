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
    // Normalize path by removing trailing slash for comparison
    final normalizedPath = uri.path.endsWith('/')
        ? uri.path.substring(0, uri.path.length - 1)
        : uri.path;
    // handle url with slice to segments
    final segments = uri.pathSegments;

    // Handle reset password deeplink
    if (normalizedPath == '/auth/password/reset' ||
        normalizedPath.startsWith('/auth/password/reset/')) {
      final token = uri.queryParameters['token'];
      final email = uri.queryParameters['email'];

      if (token != null && email != null) {
        // Decode email if it's still encoded
        final decodedEmail = Uri.decodeComponent(email);

        // Build URL with query parameters for go()
        final resetPasswordUrl = Uri(
          path: AppRouter.resetPassword,
          queryParameters: {'token': token, 'email': decodedEmail},
        ).toString();

        router.go(resetPasswordUrl);
      }
    } else {
      print('Deep link path does not match reset password pattern');
    }
    // Handle verify register email deeplink
    if (segments.length >= 5 &&
        segments[0] == 'auth' &&
        segments[1] == 'email' &&
        segments[2] == 'verify') {
      final id = segments[3];
      final hash = segments[4];
      final expires = uri.queryParameters['expires'];
      final signature = uri.queryParameters['signature'];
      final email = uri.queryParameters['email'];

      // Navigate to verify email register screen
      router.go(AppRouter.verifyEmailRegister, extra: {
        'id': id,
        'hash': hash,
        'expires': expires,
        'signature': signature,
        'email': email,
      });
    }
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
