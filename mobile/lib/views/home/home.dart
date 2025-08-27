import 'package:flutter/material.dart';
import 'package:mobile/core/config/env.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/auth/presentation/screens/login.dart';

class LibraBookApp extends StatelessWidget {
  const LibraBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
          ),
          debugShowCheckedModeBanner: false,
          home: const LoginView(),
        );
      },
    );
  }
}
