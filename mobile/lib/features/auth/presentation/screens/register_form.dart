// lib/features/auth/presentation/screens/login_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/core/utils/validators.dart';
import 'package:mobile/share/components/styled_dialog.dart';
import 'package:mobile/features/auth/presentation/provider/register_provider.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final studentCodeController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _submit() async {
    final provider = context.read<RegisterProvider>();

    if (_formKey.currentState!.validate()) {
      final result = await provider.register(
        code: studentCodeController.text,
        name: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      if (!mounted) return;

      _showStyledDialog(
        context,
        message: provider.message ?? '',
        isSuccess: result,
      );

      // clear form if success
      if (result) {
        _formKey.currentState!.reset();
        studentCodeController.clear();
        fullNameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.watch<RegisterProvider>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mã số sinh viên',
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: studentCodeController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Nhập mã sinh viên',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            validator: (value) => Validators.studentCode(value),
          ),
          SizedBox(height: 20.h),
          Text(
            'Họ và tên',
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: fullNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Nhập họ và tên',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            validator: (value) => Validators.fullName(value),
          ),
          SizedBox(height: 20.h),
          Text(
            'Email',
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'contact@vku.udn.vn',
              hintStyle: const TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            validator: (value) => Validators.email(value),
          ),
          SizedBox(height: 20.h),
          Text(
            'Mật khẩu',
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            validator: (value) => Validators.password(value),
          ),
          SizedBox(height: 20.h),
          Text(
            'Xác nhận mật khẩu',
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: confirmPasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: _obscureConfirmPassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            validator: (value) =>
                Validators.confirmPassword(value, passwordController.text),
          ),
          SizedBox(height: 8.h),

          SizedBox(height: 20.h),

          // Login button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: registerProvider.isLoading
                  ? null
                  : _submit, // Disable when loading
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF6411A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: registerProvider.isLoading
                  ? SizedBox(
                      height: 24.h,
                      width: 24.h,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFF6411A),
                        ),
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Tạo tài khoản',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
            ),
          ),

          SizedBox(height: 30.h),

          // Divider
          Row(
            children: [
              Expanded(child: Divider(thickness: 1, color: Colors.grey[400])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Hoặc đăng ký với",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ),
              Expanded(child: Divider(thickness: 1, color: Colors.grey[400])),
            ],
          ),

          SizedBox(height: 30.h),

          // Google Sign In
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () async {
                // show dialog to enter student code
                await _handleRegisterGoogle(registerProvider);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                side: const BorderSide(color: Colors.black54, width: 1),
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
                    'Đăng ký với Google',
                    style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  @override
  void dispose() {
    studentCodeController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _showStyledDialog(
    BuildContext context, {
    required String message,
    required bool isSuccess,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StyledDialog(
        message: message,
        isSuccess: isSuccess,
      ),
    );
  }

  Future<void> _handleRegisterGoogle(RegisterProvider provider) async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const _StudentCodeDialog();
      },
    );

    if (result != null && result.isNotEmpty) {
      if (!mounted) return;

      await provider.registerGoogle(result);

      if (provider.isShowDialog && provider.errorMessageRegisterGoogle != null) {
        if (!mounted) return;

        if (provider.errorMessageRegisterGoogle!.isNotEmpty) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => StyledDialog(
              message: provider.errorMessageRegisterGoogle!,
              isSuccess: false,
            ),
          );
        }
      } else {
          context.go(AppRouter.home);
      }
    }
  }
}

class _StudentCodeDialog extends StatefulWidget {
  const _StudentCodeDialog();

  @override
  State<_StudentCodeDialog> createState() => _StudentCodeDialogState();
}

class _StudentCodeDialogState extends State<_StudentCodeDialog> {
  final _dialogFormKey = GlobalKey<FormState>();
  final _dialogStudentCodeController = TextEditingController();

  @override
  void dispose() {
    _dialogStudentCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Form(
            key: _dialogFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nhập mã sinh viên',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Vui lòng nhập mã sinh viên của bạn để tiếp tục đăng ký với Google',
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Mã số sinh viên',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _dialogStudentCodeController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Nhập mã sinh viên (VD: 22IT123)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    prefixIcon: const Icon(Icons.badge_outlined),
                  ),
                  validator: (value) => Validators.studentCode(value),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: Text(
                          'Hủy',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_dialogFormKey.currentState!.validate()) {
                            final code = _dialogStudentCodeController.text;
                            Navigator.of(context).pop(code);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF6411A),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Xác nhận',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
