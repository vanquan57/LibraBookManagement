import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/di/injection.dart';
import 'package:mobile/features/auth/presentation/provider/login_provider.dart';
import 'package:mobile/features/auth/presentation/provider/register_provider.dart';
import 'package:mobile/features/auth/presentation/screens/login_form.dart';
import 'package:mobile/features/auth/presentation/screens/register_form.dart';
import 'package:provider/provider.dart';

class LoginSignupSwitcher extends StatefulWidget {
  const LoginSignupSwitcher({super.key});

  @override
  State<LoginSignupSwitcher> createState() => _LoginSignupSwitcherState();
}

class _LoginSignupSwitcherState extends State<LoginSignupSwitcher> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<LoginProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<RegisterProvider>()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTab(
                    title: 'Đăng nhập',
                    selected: isLogin,
                    onTap: () {
                      setState(() => isLogin = true);
                    },
                  ),
                  SizedBox(width: 40.w),
                  _buildTab(
                    title: 'Đăng ký',
                    selected: !isLogin,
                    onTap: () {
                      setState(() => isLogin = false);
                    },
                  ),
                ],
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Align(
                    key: ValueKey<bool>(isLogin),
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 32.h,
                      ),
                      child: isLogin ? const LoginForm() : const RegisterForm(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTab({
  required String title,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.blue : Colors.grey.shade400,
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          height: 2.h,
          width: 100.w,
          color: selected ? Colors.blue : Colors.transparent,
        ),
      ],
    ),
  );
}
