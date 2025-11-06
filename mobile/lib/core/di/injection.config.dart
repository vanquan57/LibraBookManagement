// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/post_login.dart' as _i892;
import '../../features/auth/domain/usecases/post_login_google.dart' as _i332;
import '../../features/auth/domain/usecases/post_register.dart' as _i166;
import '../../features/auth/domain/usecases/post_register_google.dart'
    as _i1046;
import '../../features/auth/presentation/provider/login_provider.dart' as _i987;
import '../../features/auth/presentation/provider/register_provider.dart'
    as _i1046;
import '../network/dio_client.dart' as _i667;
import '../storage/local_storage_service.dart' as _i744;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final localStorageModule = _$LocalStorageModule();
    final dioModule = _$DioModule();
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => localStorageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i744.LocalStorageService>(
        () => _i744.LocalStorageService(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i667.DioClient>(
        () => _i667.DioClient(gh<_i744.LocalStorageService>()));
    gh.lazySingleton<_i361.Dio>(
        () => dioModule.provideDio(gh<_i667.DioClient>()));
    gh.lazySingleton<_i161.AuthRemoteDataSource>(
        () => _i161.AuthRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i787.AuthRepository>(
        () => _i153.AuthRepositoryImpl(gh<_i161.AuthRemoteDataSource>()));
    gh.lazySingleton<_i892.PostLoginUseCase>(
        () => _i892.PostLoginUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i332.PostLoginGoogleUseCase>(
        () => _i332.PostLoginGoogleUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i166.PostRegisterUseCase>(
        () => _i166.PostRegisterUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i1046.PostRegisterGoogleUseCase>(
        () => _i1046.PostRegisterGoogleUseCase(gh<_i787.AuthRepository>()));
    gh.factory<_i987.LoginProvider>(() => _i987.LoginProvider(
          postLoginUseCase: gh<_i892.PostLoginUseCase>(),
          postLoginGoogleUseCase: gh<_i332.PostLoginGoogleUseCase>(),
          localStorageService: gh<_i744.LocalStorageService>(),
        ));
    gh.factory<_i1046.RegisterProvider>(() => _i1046.RegisterProvider(
          postRegisterUseCase: gh<_i166.PostRegisterUseCase>(),
          postRegisterGoogleUseCase: gh<_i1046.PostRegisterGoogleUseCase>(),
          localStorageService: gh<_i744.LocalStorageService>(),
        ));
    return this;
  }
}

class _$LocalStorageModule extends _i744.LocalStorageModule {}

class _$DioModule extends _i667.DioModule {}
