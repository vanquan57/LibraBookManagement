import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:mobile/features/auth/domain/usecases/post_login.dart';
import 'package:mobile/features/auth/domain/usecases/post_login_google.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/core/storage/local_storage_service.dart';
import 'package:mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile/features/auth/presentation/provider/login_provider.dart';
import 'package:mobile/features/auth/presentation/screens/login_form.dart';
import 'package:mobile/features/auth/presentation/screens/login_signup_switcher.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LocalStorageService>(create: (_) => LocalStorageService()),
        Provider<DioClient>(
          create: (context) =>
              DioClient(storageService: context.read<LocalStorageService>()),
        ),
        Provider<AuthRemoteDataSource>(
          create: (context) =>
              AuthRemoteDataSource(dio: context.read<DioClient>().dio),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            remoteDataSource: context.read<AuthRemoteDataSource>(),
          ),
        ),
        Provider<PostLoginUseCase>(
          create: (context) =>
              PostLoginUseCase(repository: context.read<AuthRepository>()),
        ),
        Provider<PostLoginGoogleUseCase>(
          create: (context) =>
              PostLoginGoogleUseCase(repository: context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(
              postLoginUseCase: context.read<PostLoginUseCase>(),
              postLoginGoogleUseCase: context.read<PostLoginGoogleUseCase>(),
              localStorageService: context.read<LocalStorageService>(),
          ),
        ),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  const LoginSignupSwitcher(),
                  SizedBox(height: 30.h),
                  const LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
