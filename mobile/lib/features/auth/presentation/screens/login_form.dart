import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/config/env.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/features/auth/presentation/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  String? errorMessage;
  String? errorMessageLoginGoogle;
  bool isShowDialog = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginProvider>().login(
        emailController.text,
        passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();
    final errorMessage = loginProvider.errorMessage;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email
          Text(
            'Email',
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'contact@dscode.com',
              hintStyle: TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập email';
              } else if (!value.endsWith(AppConstants.EMAIL_VKU)) {
                return 'Địa chỉ email không hợp lệ';
              }

              return null;
            },
          ),
          SizedBox(height: 20.h),

          // Password
          Text(
            'Mật khẩu',
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: passwordController,
            obscureText: _obscurePassword,
            style: TextStyle(color: Colors.black54),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: errorMessage != null
                    ? const BorderSide(color: Colors.red)
                    : BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: errorMessage != null
                    ? const BorderSide(color: Colors.red)
                    : BorderSide(color: Colors.grey.shade400),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Vui lòng nhập mật khẩu';
              return null;
            },
          ),

          SizedBox(height: 8.h),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                errorMessage ?? '',
                style: TextStyle(color: Colors.red, fontSize: 12.sp),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Quên mật khẩu?',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Continue button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: loginProvider.isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF6411A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: loginProvider.isLoading
                  ? SizedBox(
                      height: 24.h,
                      width: 24.h,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Đăng nhập',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              Expanded(child: Divider(thickness: 1, color: Colors.grey[400])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Hoặc đăng nhập với",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ),
              Expanded(child: Divider(thickness: 1, color: Colors.grey[400])),
            ],
          ),
          SizedBox(height: 30.h),

          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () async {
                await loginProvider.loginGoogle();

                if (loginProvider.isShowDialog && loginProvider.errorMessageLoginGoogle != null) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Lỗi'),
                      content: Text(loginProvider.errorMessageLoginGoogle!),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            loginProvider.resetDialogState();
                          },
                          child: const Text('Đóng'),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                side: BorderSide(color: Colors.black54, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_google.png',
                    height: 24.h,
                    width: 24.w,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Đăng nhập với Google',
                    style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
