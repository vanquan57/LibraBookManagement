import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/share/provider/global/check_login_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

GoRoute protectedRoute({
  required String path,
  required String pathLogin,
  Widget? child,
  Widget Function(BuildContext context, GoRouterState state)? builder,
  dynamic Function()? providerFactory,
}) {
  return GoRoute(
    path: path,
    builder: (context, state) {
      // Get the widget from either child or builder
      final widget = child ?? builder!(context, state);
      
      // If no providers, return widget directly
      if (providerFactory == null) {
        return widget;
      }

      // Wrap with providers
      final providers = providerFactory();
      final providerList = providers is List
          ? providers.cast<SingleChildWidget>()
          : [providers as SingleChildWidget];

      return MultiProvider(providers: providerList, child: widget);
    },
    redirect: (context, state) async {
      final checkLoginProvider = Provider.of<CheckLoginProvider>(
        context,
        listen: false,
      );

      await checkLoginProvider.checkIsLogin();

      if (!checkLoginProvider.isLogin) {
        return pathLogin;
      }

      return null;
    },
  );
}

Future<bool> ensureLogin(BuildContext context) async {
  final loginProvider = context.read<CheckLoginProvider>();
  await loginProvider.checkIsLogin();

  if (loginProvider.isLogin) {
    return true;
  }
  
  context.push('/auth');

  return false;
}
