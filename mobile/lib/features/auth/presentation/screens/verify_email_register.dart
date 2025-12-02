import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/auth/domain/usecases/get_verify_register_email.dart';
import 'package:mobile/features/auth/presentation/provider/verify_email_register_provider.dart';
import 'package:mobile/share/components/styled_dialog.dart';
import 'package:provider/provider.dart';

class VerifyEmailRegister extends StatefulWidget {
  final String id;
  final String hash;
  final String expires;
  final String signature;

  const VerifyEmailRegister({
    super.key,
    required this.id,
    required this.hash,
    required this.expires,
    required this.signature,
  });

  @override
  State<VerifyEmailRegister> createState() => _VerifyEmailRegisterState();
}

class _VerifyEmailRegisterState extends State<VerifyEmailRegister> {
  @override
  void initState() {
    super.initState();
    final verifyEmailProvider = context.read<VerifyEmailRegisterProvider>();
    final params = VerifyRegisterEmailParams(
      id: widget.id,
      hash: widget.hash,
      expires: widget.expires,
      signature: widget.signature,
    );

    verifyEmailProvider.verifyEmailRegister(params);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VerifyEmailRegisterProvider>(
      builder: (context, provider, _) {
        _showVerifyEmailDialog(provider);

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          color: Colors.white,
          child: Center(
            child: provider.isLoading
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 2, 165, 62),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Đang xác thực email đăng ký...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  /// Show Verify Email result dialog
  ///
  /// @param {VerifyEmailProvider} verifyEmailProvider
  ///
  /// @return {void}
  void _showVerifyEmailDialog(
    VerifyEmailRegisterProvider verifyEmailRegisterProvider,
  ) {
    if (verifyEmailRegisterProvider.isShowDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (verifyEmailRegisterProvider.message != null) {
          // Success case - reset form
          if (!mounted) return;

          final successMessage = verifyEmailRegisterProvider.message!;

          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) =>
                StyledDialog(message: successMessage, isSuccess: true),
          );

          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.of(context).pop();
              context.go(AppRouter.auth);
            }
          });
        } else if (verifyEmailRegisterProvider.errorMessage != null) {
          // Error case
          if (!mounted) return;

          final errorMessage = verifyEmailRegisterProvider.errorMessage!;

          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) =>
                StyledDialog(message: errorMessage, isSuccess: false),
          );
        }

        verifyEmailRegisterProvider.resetDialogState();
      });
    }
  }
}
