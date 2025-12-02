import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/di/injection.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/core/services/deep_link_service.dart';
import 'package:mobile/features/cart/presentation/provider/cart_provider.dart';
import 'package:mobile/features/wishlist/presentation/provider/wishlist_provider.dart';
import 'package:mobile/share/provider/global/check_login_provider.dart';
import 'package:mobile/share/provider/global/header_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await configureDependencies();
  await getIt.allReady();

  // Initialize DeepLinkService
  final deepLinkService = DeepLinkService();
  await deepLinkService.init(AppRouter.router);

  runApp(
    MyApp(deepLinkService: deepLinkService),
  );
}

class MyApp extends StatefulWidget {
  final DeepLinkService deepLinkService;

  const MyApp({super.key, required this.deepLinkService});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    widget.deepLinkService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => getIt<CheckLoginProvider>()),
            ChangeNotifierProvider(
              create: (_) => getIt<WishlistProvider>(),
            ),
            ChangeNotifierProvider(
              create: (_) => getIt<WishlistProvider>(),
            ),
            ChangeNotifierProvider(
              create: (_) => getIt<CartProvider>(),
            ),
            ChangeNotifierProvider(
              create: (_) => getIt<HeaderProvider>(),
            ),
          ],
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
            ),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
