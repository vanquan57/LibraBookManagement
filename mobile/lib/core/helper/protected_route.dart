import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/share/provider/global/check_login_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

GoRoute protectedRoute({
  required String path,
  required String pathLogin,
  required Widget child,
  dynamic Function()? providerFactory,
}) {
  return GoRoute(
    path: path,
    builder: (_, __) {
      if (providerFactory == null) {
        return child;
      }

      final providers = providerFactory();

      final providerList = providers is List
          ? providers.cast<SingleChildWidget>()
          : [providers as SingleChildWidget];

      return MultiProvider(providers: providerList, child: child);
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
