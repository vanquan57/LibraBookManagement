import 'package:flutter/material.dart';
import 'package:mobile/core/config/env.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/router/app_router.dart'; // ✅ Import router

class LibraBookApp extends StatelessWidget {
  const LibraBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home'));
  }
}
