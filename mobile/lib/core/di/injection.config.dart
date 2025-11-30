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
import '../../features/auth/domain/usecases/update_password.dart' as _i455;
import '../../features/auth/presentation/provider/change_password_provider.dart'
    as _i872;
import '../../features/auth/presentation/provider/login_provider.dart' as _i987;
import '../../features/auth/presentation/provider/register_provider.dart'
    as _i1046;
import '../../features/book_details/data/datasources/book/book_remote_datasource.dart'
    as _i432;
import '../../features/book_details/data/datasources/feedback/feedback_remote_datasource.dart'
    as _i100;
import '../../features/book_details/data/repositories/book/book_details_repository_impl.dart'
    as _i1054;
import '../../features/book_details/data/repositories/feedback/feedback_repository_impl.dart'
    as _i93;
import '../../features/book_details/domain/repositories/book/book_repository.dart'
    as _i565;
import '../../features/book_details/domain/repositories/feedback/feedback_repository.dart'
    as _i748;
import '../../features/book_details/domain/usecase/book/get_book_details.dart'
    as _i733;
import '../../features/book_details/domain/usecase/book/get_book_same_category.dart'
    as _i641;
import '../../features/book_details/domain/usecase/feedback/create_feedback.dart'
    as _i274;
import '../../features/book_details/domain/usecase/feedback/get_feedbacks.dart'
    as _i593;
import '../../features/book_details/presentation/provider/book_details_provider.dart'
    as _i217;
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
import '../../features/list_book/data/datasources/author/author_remote_datasource.dart'
    as _i868;
import '../../features/list_book/data/datasources/book/book_remote_datasource.dart'
    as _i951;
import '../../features/list_book/data/datasources/category/category_remote_datasource.dart'
    as _i546;
import '../../features/list_book/data/datasources/publisher/publisher_remote_datasource.dart'
    as _i692;
import '../../features/list_book/data/repositories/author/author_repository_impl.dart'
    as _i756;
import '../../features/list_book/data/repositories/book/book_repository_impl.dart'
    as _i278;
import '../../features/list_book/data/repositories/category/category_repository_impl.dart'
    as _i318;
import '../../features/list_book/data/repositories/publisher/publisher_repository_impl.dart'
    as _i953;
import '../../features/list_book/domain/repositories/author/author_repository.dart'
    as _i729;
import '../../features/list_book/domain/repositories/book/book_repository.dart'
    as _i63;
import '../../features/list_book/domain/repositories/category/category_repository.dart'
    as _i270;
import '../../features/list_book/domain/repositories/publisher/publisher_repository.dart'
    as _i716;
import '../../features/list_book/domain/usecase/author/get_list_author.dart'
    as _i242;
import '../../features/list_book/domain/usecase/book/get_books.dart' as _i941;
import '../../features/list_book/domain/usecase/category/get_list_category.dart'
    as _i809;
import '../../features/list_book/domain/usecase/publisher/get_list_publisher.dart'
    as _i838;
import '../../features/list_book/presentation/provider/list_book_provider.dart'
    as _i639;
import '../../features/profile/data/datasources/district/district_remote_datasource.dart'
    as _i459;
import '../../features/profile/data/datasources/profile/profile_remote_datasource.dart'
    as _i13;
import '../../features/profile/data/datasources/province/province_remote_datasource.dart'
    as _i676;
import '../../features/profile/data/datasources/ward/ward_remote_datasource.dart'
    as _i132;
import '../../features/profile/data/repositories/address_repository_impl.dart'
    as _i49;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i334;
import '../../features/profile/domain/repositories/address_repository.dart'
    as _i11;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/usecase/address/get_districts.dart'
    as _i157;
import '../../features/profile/domain/usecase/address/get_provinces.dart'
    as _i743;
import '../../features/profile/domain/usecase/address/get_wards.dart' as _i230;
import '../../features/profile/domain/usecase/profile/get_profile.dart'
    as _i400;
import '../../features/profile/domain/usecase/profile/update_profile.dart'
    as _i1047;
import '../../features/profile/presentation/provider/profile_provider.dart'
    as _i990;
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
import '../../share/provider/global/header_provider.dart' as _i235;
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
    gh.factory<_i235.HeaderProvider>(() => _i235.HeaderProvider());
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
    gh.lazySingleton<_i432.BookRemoteDataSource>(
        () => _i432.BookRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i100.FeedbackRemoteDataSource>(
        () => _i100.FeedbackRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i763.CartRemoteDataSource>(
        () => _i763.CartRemoteDataSource(gh<_i361.Dio>()));
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
    gh.lazySingleton<_i851.BookRemoteDataSource>(
        () => _i851.BookRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i590.CategoryRemoteDataSource>(
        () => _i590.CategoryRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i868.AuthorRemoteDataSource>(
        () => _i868.AuthorRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i951.BookRemoteDataSource>(
        () => _i951.BookRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i546.CategoryRemoteDataSource>(
        () => _i546.CategoryRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i692.PublisherRemoteDataSource>(
        () => _i692.PublisherRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i706.WishlistRemoteDataSource>(
        () => _i706.WishlistRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i490.CheckLoginDatasource>(
        () => _i490.CheckLoginDatasource(gh<_i361.Dio>()));
    gh.lazySingleton<_i459.DistrictRemoteDataSource>(
        () => _i459.DistrictRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i13.ProfileRemoteDataSource>(
        () => _i13.ProfileRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i676.ProvinceRemoteDataSource>(
        () => _i676.ProvinceRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i132.WardRemoteDataSource>(
        () => _i132.WardRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i1049.CheckLoginProvider>(() => _i1049.CheckLoginProvider(
        checkLoginDatasource: gh<_i490.CheckLoginDatasource>()));
    gh.lazySingleton<_i270.CategoryRepository>(() =>
        _i318.CategoryRepositoryImpl(gh<_i546.CategoryRemoteDataSource>()));
    gh.lazySingleton<_i441.CategoryRepository>(() =>
        _i392.CategoryRepositoryImpl(gh<_i590.CategoryRemoteDataSource>()));
    gh.lazySingleton<_i24.AddressRepository>(() => _i464.AddressRepositoryImpl(
          gh<_i60.ProvinceRemoteDataSource>(),
          gh<_i737.DistrictRemoteDataSource>(),
          gh<_i400.WardRemoteDataSource>(),
        ));
    gh.lazySingleton<_i565.BookRepository>(
        () => _i1054.BookRepositoryImpl(gh<_i432.BookRemoteDataSource>()));
    gh.lazySingleton<_i716.PublisherRepository>(() =>
        _i953.PublisherRepositoryImpl(gh<_i692.PublisherRemoteDataSource>()));
    gh.lazySingleton<_i838.GetListPublisherUseCase>(
        () => _i838.GetListPublisherUseCase(gh<_i716.PublisherRepository>()));
    gh.lazySingleton<_i11.AddressRepository>(() => _i49.AddressRepositoryImpl(
          gh<_i676.ProvinceRemoteDataSource>(),
          gh<_i459.DistrictRemoteDataSource>(),
          gh<_i132.WardRemoteDataSource>(),
        ));
    gh.lazySingleton<_i809.GetListCategoriesUseCase>(
        () => _i809.GetListCategoriesUseCase(gh<_i270.CategoryRepository>()));
    gh.lazySingleton<_i787.AuthRepository>(
        () => _i153.AuthRepositoryImpl(gh<_i161.AuthRemoteDataSource>()));
    gh.lazySingleton<_i748.FeedbackRepository>(() =>
        _i93.FeedbackRepositoryImpl(gh<_i100.FeedbackRemoteDataSource>()));
    gh.lazySingleton<_i498.CheckoutRepository>(() =>
        _i949.CheckoutRepositoryImpl(gh<_i174.CheckoutRemoteDataSource>()));
    gh.lazySingleton<_i729.AuthorRepository>(
        () => _i756.AuthorRepositoryImpl(gh<_i868.AuthorRemoteDataSource>()));
    gh.lazySingleton<_i63.BookRepository>(
        () => _i278.BookRepositoryImpl(gh<_i951.BookRemoteDataSource>()));
    gh.lazySingleton<_i283.ProfileRepository>(
        () => _i81.ProfileRepositoryImpl(gh<_i398.ProfileRemoteDataSource>()));
    gh.lazySingleton<_i842.SubmitCheckoutUseCase>(
        () => _i842.SubmitCheckoutUseCase(gh<_i498.CheckoutRepository>()));
    gh.lazySingleton<_i322.CartRepository>(
        () => _i332.CartRepositoryImpl(gh<_i763.CartRemoteDataSource>()));
    gh.lazySingleton<_i242.GetListAuthorsUseCase>(
        () => _i242.GetListAuthorsUseCase(gh<_i729.AuthorRepository>()));
    gh.lazySingleton<_i772.BookRepository>(
        () => _i297.BookRepositoryImpl(gh<_i851.BookRemoteDataSource>()));
    gh.lazySingleton<_i157.GetDistrictsUseCase>(
        () => _i157.GetDistrictsUseCase(gh<_i11.AddressRepository>()));
    gh.lazySingleton<_i743.GetProvincesUseCase>(
        () => _i743.GetProvincesUseCase(gh<_i11.AddressRepository>()));
    gh.lazySingleton<_i230.GetWardsUseCase>(
        () => _i230.GetWardsUseCase(gh<_i11.AddressRepository>()));
    gh.lazySingleton<_i4.WishlistRepository>(() =>
        _i919.WishlistRepositoryImpl(gh<_i706.WishlistRemoteDataSource>()));
    gh.lazySingleton<_i894.ProfileRepository>(
        () => _i334.ProfileRepositoryImpl(gh<_i13.ProfileRemoteDataSource>()));
    gh.lazySingleton<_i258.GetListCategoriesUseCase>(
        () => _i258.GetListCategoriesUseCase(gh<_i441.CategoryRepository>()));
    gh.lazySingleton<_i23.GetDistrictsUseCase>(
        () => _i23.GetDistrictsUseCase(gh<_i24.AddressRepository>()));
    gh.lazySingleton<_i7.GetProvincesUseCase>(
        () => _i7.GetProvincesUseCase(gh<_i24.AddressRepository>()));
    gh.lazySingleton<_i320.GetWardsUseCase>(
        () => _i320.GetWardsUseCase(gh<_i24.AddressRepository>()));
    gh.lazySingleton<_i941.GetBooksUseCase>(
        () => _i941.GetBooksUseCase(gh<_i63.BookRepository>()));
    gh.lazySingleton<_i400.GetProfileUseCase>(
        () => _i400.GetProfileUseCase(gh<_i894.ProfileRepository>()));
    gh.lazySingleton<_i1047.UpdateProfileUseCase>(
        () => _i1047.UpdateProfileUseCase(gh<_i894.ProfileRepository>()));
    gh.lazySingleton<_i354.AddWishListUseCase>(
        () => _i354.AddWishListUseCase(gh<_i4.WishlistRepository>()));
    gh.lazySingleton<_i90.DeleteWishListUseCase>(
        () => _i90.DeleteWishListUseCase(gh<_i4.WishlistRepository>()));
    gh.lazySingleton<_i516.GetWishListUseCase>(
        () => _i516.GetWishListUseCase(gh<_i4.WishlistRepository>()));
    gh.lazySingleton<_i721.GetBooksUseCase>(
        () => _i721.GetBooksUseCase(gh<_i772.BookRepository>()));
    gh.lazySingleton<_i733.GetBookDetailUseCase>(
        () => _i733.GetBookDetailUseCase(gh<_i565.BookRepository>()));
    gh.lazySingleton<_i641.GetBookSameCategoryUseCase>(
        () => _i641.GetBookSameCategoryUseCase(gh<_i565.BookRepository>()));
    gh.lazySingleton<_i892.PostLoginUseCase>(
        () => _i892.PostLoginUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i332.PostLoginGoogleUseCase>(
        () => _i332.PostLoginGoogleUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i166.PostRegisterUseCase>(
        () => _i166.PostRegisterUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i1046.PostRegisterGoogleUseCase>(
        () => _i1046.PostRegisterGoogleUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i455.UpdatePasswordUseCase>(
        () => _i455.UpdatePasswordUseCase(gh<_i787.AuthRepository>()));
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
    gh.lazySingleton<_i274.CreateFeedbackUseCase>(
        () => _i274.CreateFeedbackUseCase(gh<_i748.FeedbackRepository>()));
    gh.lazySingleton<_i593.GetFeedbacksUseCase>(
        () => _i593.GetFeedbacksUseCase(gh<_i748.FeedbackRepository>()));
    gh.factory<_i687.CheckoutProvider>(() => _i687.CheckoutProvider(
          gh<_i7.GetProvincesUseCase>(),
          gh<_i23.GetDistrictsUseCase>(),
          gh<_i320.GetWardsUseCase>(),
          gh<_i879.ProfileCheckoutUseCase>(),
          gh<_i842.SubmitCheckoutUseCase>(),
        ));
    gh.factory<_i639.ListBookProvider>(() => _i639.ListBookProvider(
          getBooksUseCase: gh<_i941.GetBooksUseCase>(),
          getListCategoriesUseCase: gh<_i809.GetListCategoriesUseCase>(),
          getListPublisherUseCase: gh<_i838.GetListPublisherUseCase>(),
          getListAuthorsUseCase: gh<_i242.GetListAuthorsUseCase>(),
        ));
    gh.factory<_i376.HomeProvider>(() => _i376.HomeProvider(
          getBooksUseCase: gh<_i721.GetBooksUseCase>(),
          getListCategoriesUseCase: gh<_i258.GetListCategoriesUseCase>(),
        ));
    gh.factory<_i872.ChangePasswordProvider>(() => _i872.ChangePasswordProvider(
        updatePasswordUseCase: gh<_i455.UpdatePasswordUseCase>()));
    gh.factory<_i150.WishlistProvider>(() => _i150.WishlistProvider(
          gh<_i516.GetWishListUseCase>(),
          gh<_i354.AddWishListUseCase>(),
          gh<_i90.DeleteWishListUseCase>(),
        ));
    gh.factory<_i217.BookDetailsProvider>(() => _i217.BookDetailsProvider(
          getBookDetailUseCase: gh<_i733.GetBookDetailUseCase>(),
          getBookSameCategoryUseCase: gh<_i641.GetBookSameCategoryUseCase>(),
          getFeedbacksUseCase: gh<_i593.GetFeedbacksUseCase>(),
          createFeedbackUseCase: gh<_i274.CreateFeedbackUseCase>(),
        ));
    gh.factory<_i990.ProfileProvider>(() => _i990.ProfileProvider(
          gh<_i743.GetProvincesUseCase>(),
          gh<_i157.GetDistrictsUseCase>(),
          gh<_i230.GetWardsUseCase>(),
          gh<_i400.GetProfileUseCase>(),
          gh<_i1047.UpdateProfileUseCase>(),
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
