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
import '../../features/cart/data/datasources/cart/cart_remote_datasource.dart'
    as _i763;
import '../../features/cart/data/repositories/card_repository_impl.dart'
    as _i332;
import '../../features/cart/domain/repositories/cart_repository.dart' as _i322;
import '../../features/cart/domain/usecase/add_card.dart' as _i584;
import '../../features/cart/domain/usecase/delete_card.dart' as _i787;
import '../../features/cart/domain/usecase/get_card.dart' as _i613;
import '../../features/cart/domain/usecase/update_card.dart' as _i466;
import '../../features/cart/presentation/provider/cart_provider.dart' as _i137;
import '../../features/checkout/data/datasources/checkout/checkout_remote_datasource.dart'
    as _i174;
import '../../features/checkout/data/datasources/district/district_remote_datasource.dart'
    as _i737;
import '../../features/checkout/data/datasources/profile/profile_remote_datasource.dart'
    as _i398;
import '../../features/checkout/data/datasources/province/province_remote_datasource.dart'
    as _i60;
import '../../features/checkout/data/datasources/ward/ward_remote_datasource.dart'
    as _i400;
import '../../features/checkout/data/repositories/address_repository_impl.dart'
    as _i464;
import '../../features/checkout/data/repositories/checkout_repository_impl.dart'
    as _i949;
import '../../features/checkout/data/repositories/profile_repository_impl.dart'
    as _i81;
import '../../features/checkout/domain/repositories/address_repository.dart'
    as _i24;
import '../../features/checkout/domain/repositories/checkout_repository.dart'
    as _i498;
import '../../features/checkout/domain/repositories/profile_repository.dart'
    as _i283;
import '../../features/checkout/domain/usecase/address/get_districts.dart'
    as _i23;
import '../../features/checkout/domain/usecase/address/get_provinces.dart'
    as _i7;
import '../../features/checkout/domain/usecase/address/get_wards.dart' as _i320;
import '../../features/checkout/domain/usecase/checkout/submit_checkout.dart'
    as _i842;
import '../../features/checkout/domain/usecase/profile/profile_checkout.dart'
    as _i879;
import '../../features/checkout/presentation/provider/checkout_provider.dart'
    as _i687;
import '../../features/home/data/datasources/book/book_remote_datasource.dart'
    as _i851;
import '../../features/home/data/datasources/category/category_remote_datasource.dart'
    as _i590;
import '../../features/home/data/repositories/book/book_repository_impl.dart'
    as _i297;
import '../../features/home/data/repositories/category/category_repository_impl.dart'
    as _i392;
import '../../features/home/domain/repositories/book/book_repository.dart'
    as _i772;
import '../../features/home/domain/repositories/category/category_repository.dart'
    as _i441;
import '../../features/home/domain/usecase/book/get_books.dart' as _i721;
import '../../features/home/domain/usecase/category/get_list_category.dart'
    as _i258;
import '../../features/home/presentation/provider/home_provider.dart' as _i376;
import '../../features/wishlist/data/datasources/wishlist/wishlist_remote_datasource.dart'
    as _i706;
import '../../features/wishlist/data/repositories/wishlist_repository_impl.dart'
    as _i919;
import '../../features/wishlist/domain/repositories/wishlist_repository.dart'
    as _i4;
import '../../features/wishlist/domain/usecase/add_wishlist.dart' as _i354;
import '../../features/wishlist/domain/usecase/delete_wishlist.dart' as _i90;
import '../../features/wishlist/domain/usecase/get_wishlist.dart' as _i516;
import '../../features/wishlist/presentation/provider/wishlist_provider.dart'
    as _i150;
import '../../share/data/datasources/global/check_login_datasource.dart'
    as _i490;
import '../../share/provider/global/check_login_provider.dart' as _i1049;
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
    gh.lazySingleton<_i763.CartRemoteDataSource>(
        () => _i763.CartRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i851.BookRemoteDataSource>(
        () => _i851.BookRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i590.CategoryRemoteDataSource>(
        () => _i590.CategoryRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i706.WishlistRemoteDataSource>(
        () => _i706.WishlistRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i490.CheckLoginDatasource>(
        () => _i490.CheckLoginDatasource(gh<_i361.Dio>()));
    gh.lazySingleton<_i174.CheckoutRemoteDataSource>(
        () => _i174.CheckoutRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i737.DistrictRemoteDataSource>(
        () => _i737.DistrictRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i398.ProfileRemoteDataSource>(
        () => _i398.ProfileRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i60.ProvinceRemoteDataSource>(
        () => _i60.ProvinceRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i400.WardRemoteDataSource>(
        () => _i400.WardRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i1049.CheckLoginProvider>(() => _i1049.CheckLoginProvider(
        checkLoginDatasource: gh<_i490.CheckLoginDatasource>()));
    gh.lazySingleton<_i441.CategoryRepository>(() =>
        _i392.CategoryRepositoryImpl(gh<_i590.CategoryRemoteDataSource>()));
    gh.lazySingleton<_i24.AddressRepository>(() => _i464.AddressRepositoryImpl(
          gh<_i60.ProvinceRemoteDataSource>(),
          gh<_i737.DistrictRemoteDataSource>(),
          gh<_i400.WardRemoteDataSource>(),
        ));
    gh.lazySingleton<_i787.AuthRepository>(
        () => _i153.AuthRepositoryImpl(gh<_i161.AuthRemoteDataSource>()));
    gh.lazySingleton<_i498.CheckoutRepository>(() =>
        _i949.CheckoutRepositoryImpl(gh<_i174.CheckoutRemoteDataSource>()));
    gh.lazySingleton<_i283.ProfileRepository>(
        () => _i81.ProfileRepositoryImpl(gh<_i398.ProfileRemoteDataSource>()));
    gh.lazySingleton<_i842.SubmitCheckoutUseCase>(
        () => _i842.SubmitCheckoutUseCase(gh<_i498.CheckoutRepository>()));
    gh.lazySingleton<_i322.CartRepository>(
        () => _i332.CartRepositoryImpl(gh<_i763.CartRemoteDataSource>()));
    gh.lazySingleton<_i772.BookRepository>(
        () => _i297.BookRepositoryImpl(gh<_i851.BookRemoteDataSource>()));
    gh.lazySingleton<_i4.WishlistRepository>(() =>
        _i919.WishlistRepositoryImpl(gh<_i706.WishlistRemoteDataSource>()));
    gh.lazySingleton<_i258.GetListCategoriesUseCase>(
        () => _i258.GetListCategoriesUseCase(gh<_i441.CategoryRepository>()));
    gh.lazySingleton<_i23.GetDistrictsUseCase>(
        () => _i23.GetDistrictsUseCase(gh<_i24.AddressRepository>()));
    gh.lazySingleton<_i7.GetProvincesUseCase>(
        () => _i7.GetProvincesUseCase(gh<_i24.AddressRepository>()));
    gh.lazySingleton<_i320.GetWardsUseCase>(
        () => _i320.GetWardsUseCase(gh<_i24.AddressRepository>()));
    gh.lazySingleton<_i354.AddWishListUseCase>(
        () => _i354.AddWishListUseCase(gh<_i4.WishlistRepository>()));
    gh.lazySingleton<_i90.DeleteWishListUseCase>(
        () => _i90.DeleteWishListUseCase(gh<_i4.WishlistRepository>()));
    gh.lazySingleton<_i516.GetWishListUseCase>(
        () => _i516.GetWishListUseCase(gh<_i4.WishlistRepository>()));
    gh.lazySingleton<_i721.GetBooksUseCase>(
        () => _i721.GetBooksUseCase(gh<_i772.BookRepository>()));
    gh.lazySingleton<_i892.PostLoginUseCase>(
        () => _i892.PostLoginUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i332.PostLoginGoogleUseCase>(
        () => _i332.PostLoginGoogleUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i166.PostRegisterUseCase>(
        () => _i166.PostRegisterUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i1046.PostRegisterGoogleUseCase>(
        () => _i1046.PostRegisterGoogleUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i584.AddCartUseCase>(
        () => _i584.AddCartUseCase(gh<_i322.CartRepository>()));
    gh.lazySingleton<_i787.DeleteCartUseCase>(
        () => _i787.DeleteCartUseCase(gh<_i322.CartRepository>()));
    gh.lazySingleton<_i613.GetCartUseCase>(
        () => _i613.GetCartUseCase(gh<_i322.CartRepository>()));
    gh.lazySingleton<_i466.UpdateCartUseCase>(
        () => _i466.UpdateCartUseCase(gh<_i322.CartRepository>()));
    gh.lazySingleton<_i879.ProfileCheckoutUseCase>(
        () => _i879.ProfileCheckoutUseCase(gh<_i283.ProfileRepository>()));
    gh.factory<_i687.CheckoutProvider>(() => _i687.CheckoutProvider(
          gh<_i7.GetProvincesUseCase>(),
          gh<_i23.GetDistrictsUseCase>(),
          gh<_i320.GetWardsUseCase>(),
          gh<_i879.ProfileCheckoutUseCase>(),
          gh<_i842.SubmitCheckoutUseCase>(),
        ));
    gh.factory<_i376.HomeProvider>(() => _i376.HomeProvider(
          getBooksUseCase: gh<_i721.GetBooksUseCase>(),
          getListCategoriesUseCase: gh<_i258.GetListCategoriesUseCase>(),
        ));
    gh.factory<_i150.WishlistProvider>(() => _i150.WishlistProvider(
          gh<_i516.GetWishListUseCase>(),
          gh<_i354.AddWishListUseCase>(),
          gh<_i90.DeleteWishListUseCase>(),
        ));
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
    gh.factory<_i137.CartProvider>(() => _i137.CartProvider(
          gh<_i613.GetCartUseCase>(),
          gh<_i584.AddCartUseCase>(),
          gh<_i787.DeleteCartUseCase>(),
          gh<_i466.UpdateCartUseCase>(),
        ));
    return this;
  }
}

class _$LocalStorageModule extends _i744.LocalStorageModule {}

class _$DioModule extends _i667.DioModule {}
