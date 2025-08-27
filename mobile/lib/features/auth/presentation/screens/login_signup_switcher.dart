import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginSignupSwitcher extends StatefulWidget {
  const LoginSignupSwitcher({super.key});

  @override
  State<LoginSignupSwitcher> createState() => _LoginSignupSwitcherState();
}

class _LoginSignupSwitcherState extends State<LoginSignupSwitcher> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Row(
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
