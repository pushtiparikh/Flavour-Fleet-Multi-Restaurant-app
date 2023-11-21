// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i42;
import 'package:flutter/material.dart' as _i43;
import 'package:pull_to_refresh/pull_to_refresh.dart' as _i47;

import '../../infrastructure/models/data/address_new_data.dart' as _i46;
import '../../infrastructure/models/data/user.dart' as _i44;
import '../../infrastructure/models/models.dart' as _i45;
import '../pages/auth/confirmation/register_confirmation_page.dart' as _i6;
import '../pages/auth/login/login_page.dart' as _i3;
import '../pages/auth/register/register_page.dart' as _i7;
import '../pages/auth/reset/reset_password_page.dart' as _i5;
import '../pages/chat/chat/chat_page.dart' as _i30;
import '../pages/generate_image/generate_image_page.dart' as _i31;
import '../pages/home/filter/result_filter.dart' as _i23;
import '../pages/home/widgets/recommended_screen.dart' as _i17;
import '../pages/home/widgets/shops_banner_page.dart' as _i26;
import '../pages/home_one/widget/recommended_one_screen.dart' as _i18;
import '../pages/home_three/widgets/recommended_three_screen.dart' as _i34;
import '../pages/home_two/widget/recommended_two_screen.dart' as _i19;
import '../pages/initial/no_connection/no_connection_page.dart' as _i2;
import '../pages/initial/splash/splash_page.dart' as _i1;
import '../pages/initial/ui_type/ui_type_page.dart' as _i4;
import '../pages/like/like_page.dart' as _i37;
import '../pages/main/main_page.dart' as _i8;
import '../pages/order/order_screen/order_progress_screen.dart' as _i22;
import '../pages/order/order_screen/order_screen.dart' as _i12;
import '../pages/order/orders_page.dart' as _i10;
import '../pages/parcel/parcel_list_page.dart' as _i38;
import '../pages/parcel/parcel_order_page.dart' as _i39;
import '../pages/parcel/parcel_page.dart' as _i35;
import '../pages/parcel/widgets/info_screen.dart' as _i36;
import '../pages/profile/address_list.dart' as _i41;
import '../pages/profile/become_seller/create_shop.dart' as _i25;
import '../pages/profile/help_page.dart' as _i21;
import '../pages/profile/notification_page.dart' as _i32;
import '../pages/profile/profile_page.dart' as _i14;
import '../pages/profile/share_referral_faq.dart' as _i29;
import '../pages/profile/share_referral_page.dart' as _i28;
import '../pages/profile/wallet_history.dart' as _i24;
import '../pages/search/search_page.dart' as _i13;
import '../pages/service/service_two_category_page.dart' as _i33;
import '../pages/setting/setting_page.dart' as _i11;
import '../pages/shop/shop_detail.dart' as _i27;
import '../pages/shop/shop_page.dart' as _i9;
import '../pages/shop/sub_category_screen.dart' as _i40;
import '../pages/story_page/story_page.dart' as _i16;
import '../pages/view_map/map_search_page.dart' as _i20;
import '../pages/view_map/view_map_page.dart' as _i15;

class AppRouter extends _i42.RootStackRouter {
  AppRouter([_i43.GlobalKey<_i43.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i42.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    NoConnectionRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.NoConnectionPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.LoginPage(),
      );
    },
    UiTypeRoute.name: (routeData) {
      final args = routeData.argsAs<UiTypeRouteArgs>(
          orElse: () => const UiTypeRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.UiTypePage(
          key: args.key,
          isBack: args.isBack,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.ResetPasswordPage(),
      );
    },
    RegisterConfirmationRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterConfirmationRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.RegisterConfirmationPage(
          key: args.key,
          userModel: args.userModel,
          isResetPassword: args.isResetPassword,
          verificationId: args.verificationId,
          editPhone: args.editPhone,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.RegisterPage(
          key: args.key,
          isOnlyEmail: args.isOnlyEmail,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.MainPage(),
      );
    },
    ShopRoute.name: (routeData) {
      final args = routeData.argsAs<ShopRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.ShopPage(
          key: args.key,
          shopId: args.shopId,
          productId: args.productId,
          cartId: args.cartId,
          shop: args.shop,
          ownerId: args.ownerId,
        ),
      );
    },
    OrdersListRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.OrdersListPage(),
      );
    },
    SettingRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.SettingPage(),
      );
    },
    OrderRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.OrderPage(),
      );
    },
    SearchRoute.name: (routeData) {
      final args = routeData.argsAs<SearchRouteArgs>(
          orElse: () => const SearchRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.SearchPage(
          key: args.key,
          isBackButton: args.isBackButton,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => const ProfileRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.ProfilePage(
          key: args.key,
          isBackButton: args.isBackButton,
        ),
      );
    },
    ViewMapRoute.name: (routeData) {
      final args = routeData.argsAs<ViewMapRouteArgs>(
          orElse: () => const ViewMapRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.ViewMapPage(
          key: args.key,
          isPop: args.isPop,
          isShopLocation: args.isShopLocation,
          shopId: args.shopId,
          indexAddress: args.indexAddress,
          address: args.address,
        ),
      );
    },
    StoryList.name: (routeData) {
      final args = routeData.argsAs<StoryListArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.StoryList(
          key: args.key,
          index: args.index,
          controller: args.controller,
        ),
      );
    },
    RecommendedRoute.name: (routeData) {
      final args = routeData.argsAs<RecommendedRouteArgs>(
          orElse: () => const RecommendedRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.RecommendedPage(
          key: args.key,
          isNewsOfPage: args.isNewsOfPage,
          isShop: args.isShop,
        ),
      );
    },
    RecommendedOneRoute.name: (routeData) {
      final args = routeData.argsAs<RecommendedOneRouteArgs>(
          orElse: () => const RecommendedOneRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.RecommendedOnePage(
          key: args.key,
          isNewsOfPage: args.isNewsOfPage,
          isShop: args.isShop,
        ),
      );
    },
    RecommendedTwoRoute.name: (routeData) {
      final args = routeData.argsAs<RecommendedTwoRouteArgs>(
          orElse: () => const RecommendedTwoRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i19.RecommendedTwoPage(
          key: args.key,
          isNewsOfPage: args.isNewsOfPage,
          isShop: args.isShop,
          isPopular: args.isPopular,
        ),
      );
    },
    MapSearchRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i20.MapSearchPage(),
      );
    },
    HelpRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i21.HelpPage(),
      );
    },
    OrderProgressRoute.name: (routeData) {
      final args = routeData.argsAs<OrderProgressRouteArgs>(
          orElse: () => const OrderProgressRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i22.OrderProgressPage(
          key: args.key,
          orderId: args.orderId,
        ),
      );
    },
    ResultFilter.name: (routeData) {
      final args = routeData.argsAs<ResultFilterArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i23.ResultFilter(
          key: args.key,
          categoryId: args.categoryId,
        ),
      );
    },
    WalletHistory.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i24.WalletHistory(),
      );
    },
    CreateShop.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i25.CreateShop(),
      );
    },
    ShopsBannerRoute.name: (routeData) {
      final args = routeData.argsAs<ShopsBannerRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i26.ShopsBannerPage(
          key: args.key,
          bannerId: args.bannerId,
          title: args.title,
          isAds: args.isAds,
        ),
      );
    },
    ShopDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ShopDetailRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i27.ShopDetailPage(
          key: args.key,
          shop: args.shop,
          workTime: args.workTime,
        ),
      );
    },
    ShareReferralRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i28.ShareReferralPage(),
      );
    },
    ShareReferralFaq.name: (routeData) {
      final args = routeData.argsAs<ShareReferralFaqArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i29.ShareReferralFaq(
          key: args.key,
          terms: args.terms,
        ),
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i30.ChatPage(
          key: args.key,
          roleId: args.roleId,
          name: args.name,
        ),
      );
    },
    GenerateImageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i31.GenerateImagePage(),
      );
    },
    NotificationListRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i32.NotificationListPage(),
      );
    },
    ServiceTwoCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<ServiceTwoCategoryRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i33.ServiceTwoCategoryPage(
          key: args.key,
          index: args.index,
        ),
      );
    },
    RecommendedThreeRoute.name: (routeData) {
      final args = routeData.argsAs<RecommendedThreeRouteArgs>(
          orElse: () => const RecommendedThreeRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i34.RecommendedThreePage(
          key: args.key,
          isNewsOfPage: args.isNewsOfPage,
          isShop: args.isShop,
          isPopular: args.isPopular,
        ),
      );
    },
    ParcelRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i35.ParcelPage(),
      );
    },
    InfoRoute.name: (routeData) {
      final args = routeData.argsAs<InfoRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i36.InfoPage(
          key: args.key,
          index: args.index,
        ),
      );
    },
    LikeRoute.name: (routeData) {
      final args =
          routeData.argsAs<LikeRouteArgs>(orElse: () => const LikeRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i37.LikePage(
          key: args.key,
          isBackButton: args.isBackButton,
        ),
      );
    },
    ParcelListRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i38.ParcelListPage(),
      );
    },
    ParcelProgressRoute.name: (routeData) {
      final args = routeData.argsAs<ParcelProgressRouteArgs>(
          orElse: () => const ParcelProgressRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i39.ParcelProgressPage(
          key: args.key,
          parcelId: args.parcelId,
        ),
      );
    },
    SubCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<SubCategoryRouteArgs>();
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i40.SubCategoryPage(
          key: args.key,
          category: args.category,
          shopId: args.shopId,
          cartId: args.cartId,
        ),
      );
    },
    AddressListRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i41.AddressListPage(),
      );
    },
  };

  @override
  List<_i42.RouteConfig> get routes => [
        _i42.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i42.RouteConfig(
          NoConnectionRoute.name,
          path: '/no-connection',
        ),
        _i42.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i42.RouteConfig(
          UiTypeRoute.name,
          path: '/ui-type',
        ),
        _i42.RouteConfig(
          ResetPasswordRoute.name,
          path: '/reset',
        ),
        _i42.RouteConfig(
          RegisterConfirmationRoute.name,
          path: '/register-confirmation',
        ),
        _i42.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        _i42.RouteConfig(
          MainRoute.name,
          path: '/main',
        ),
        _i42.RouteConfig(
          ShopRoute.name,
          path: '/shop',
        ),
        _i42.RouteConfig(
          OrdersListRoute.name,
          path: '/order',
        ),
        _i42.RouteConfig(
          SettingRoute.name,
          path: '/setting',
        ),
        _i42.RouteConfig(
          OrderRoute.name,
          path: '/orderScreen',
        ),
        _i42.RouteConfig(
          SearchRoute.name,
          path: '/searchPage',
        ),
        _i42.RouteConfig(
          ProfileRoute.name,
          path: '/ProfilePage',
        ),
        _i42.RouteConfig(
          ViewMapRoute.name,
          path: '/map',
        ),
        _i42.RouteConfig(
          StoryList.name,
          path: '/storyList',
        ),
        _i42.RouteConfig(
          RecommendedRoute.name,
          path: '/recommended',
        ),
        _i42.RouteConfig(
          RecommendedOneRoute.name,
          path: '/recommended_one',
        ),
        _i42.RouteConfig(
          RecommendedTwoRoute.name,
          path: '/recommended_two',
        ),
        _i42.RouteConfig(
          MapSearchRoute.name,
          path: '/map_search',
        ),
        _i42.RouteConfig(
          HelpRoute.name,
          path: '/help',
        ),
        _i42.RouteConfig(
          OrderProgressRoute.name,
          path: '/order_progress',
        ),
        _i42.RouteConfig(
          ResultFilter.name,
          path: '/result_filter',
        ),
        _i42.RouteConfig(
          WalletHistory.name,
          path: '/wallet_history',
        ),
        _i42.RouteConfig(
          CreateShop.name,
          path: '/create_shop',
        ),
        _i42.RouteConfig(
          ShopsBannerRoute.name,
          path: '/shops_banner',
        ),
        _i42.RouteConfig(
          ShopDetailRoute.name,
          path: '/shops_detail',
        ),
        _i42.RouteConfig(
          ShareReferralRoute.name,
          path: '/share_referral',
        ),
        _i42.RouteConfig(
          ShareReferralFaq.name,
          path: '/share_referral_faq',
        ),
        _i42.RouteConfig(
          ChatRoute.name,
          path: '/chat',
        ),
        _i42.RouteConfig(
          GenerateImageRoute.name,
          path: '/generate_image',
        ),
        _i42.RouteConfig(
          NotificationListRoute.name,
          path: '/notification_list_page',
        ),
        _i42.RouteConfig(
          ServiceTwoCategoryRoute.name,
          path: '/service_two_category_page',
        ),
        _i42.RouteConfig(
          RecommendedThreeRoute.name,
          path: '/recommended_three',
        ),
        _i42.RouteConfig(
          ParcelRoute.name,
          path: '/parcel_page',
        ),
        _i42.RouteConfig(
          InfoRoute.name,
          path: '/info_screen',
        ),
        _i42.RouteConfig(
          LikeRoute.name,
          path: '/like_page',
        ),
        _i42.RouteConfig(
          ParcelListRoute.name,
          path: '/parcel_list_page',
        ),
        _i42.RouteConfig(
          ParcelProgressRoute.name,
          path: '/parcel_progress_page',
        ),
        _i42.RouteConfig(
          SubCategoryRoute.name,
          path: '/sub_category_page',
        ),
        _i42.RouteConfig(
          AddressListRoute.name,
          path: '/address_list_page',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i42.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.NoConnectionPage]
class NoConnectionRoute extends _i42.PageRouteInfo<void> {
  const NoConnectionRoute()
      : super(
          NoConnectionRoute.name,
          path: '/no-connection',
        );

  static const String name = 'NoConnectionRoute';
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i42.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.UiTypePage]
class UiTypeRoute extends _i42.PageRouteInfo<UiTypeRouteArgs> {
  UiTypeRoute({
    _i43.Key? key,
    bool isBack = false,
  }) : super(
          UiTypeRoute.name,
          path: '/ui-type',
          args: UiTypeRouteArgs(
            key: key,
            isBack: isBack,
          ),
        );

  static const String name = 'UiTypeRoute';
}

class UiTypeRouteArgs {
  const UiTypeRouteArgs({
    this.key,
    this.isBack = false,
  });

  final _i43.Key? key;

  final bool isBack;

  @override
  String toString() {
    return 'UiTypeRouteArgs{key: $key, isBack: $isBack}';
  }
}

/// generated route for
/// [_i5.ResetPasswordPage]
class ResetPasswordRoute extends _i42.PageRouteInfo<void> {
  const ResetPasswordRoute()
      : super(
          ResetPasswordRoute.name,
          path: '/reset',
        );

  static const String name = 'ResetPasswordRoute';
}

/// generated route for
/// [_i6.RegisterConfirmationPage]
class RegisterConfirmationRoute
    extends _i42.PageRouteInfo<RegisterConfirmationRouteArgs> {
  RegisterConfirmationRoute({
    _i43.Key? key,
    required _i44.UserModel userModel,
    bool isResetPassword = false,
    required String verificationId,
    bool editPhone = false,
  }) : super(
          RegisterConfirmationRoute.name,
          path: '/register-confirmation',
          args: RegisterConfirmationRouteArgs(
            key: key,
            userModel: userModel,
            isResetPassword: isResetPassword,
            verificationId: verificationId,
            editPhone: editPhone,
          ),
        );

  static const String name = 'RegisterConfirmationRoute';
}

class RegisterConfirmationRouteArgs {
  const RegisterConfirmationRouteArgs({
    this.key,
    required this.userModel,
    this.isResetPassword = false,
    required this.verificationId,
    this.editPhone = false,
  });

  final _i43.Key? key;

  final _i44.UserModel userModel;

  final bool isResetPassword;

  final String verificationId;

  final bool editPhone;

  @override
  String toString() {
    return 'RegisterConfirmationRouteArgs{key: $key, userModel: $userModel, isResetPassword: $isResetPassword, verificationId: $verificationId, editPhone: $editPhone}';
  }
}

/// generated route for
/// [_i7.RegisterPage]
class RegisterRoute extends _i42.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    _i43.Key? key,
    required bool isOnlyEmail,
  }) : super(
          RegisterRoute.name,
          path: '/register',
          args: RegisterRouteArgs(
            key: key,
            isOnlyEmail: isOnlyEmail,
          ),
        );

  static const String name = 'RegisterRoute';
}

class RegisterRouteArgs {
  const RegisterRouteArgs({
    this.key,
    required this.isOnlyEmail,
  });

  final _i43.Key? key;

  final bool isOnlyEmail;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, isOnlyEmail: $isOnlyEmail}';
  }
}

/// generated route for
/// [_i8.MainPage]
class MainRoute extends _i42.PageRouteInfo<void> {
  const MainRoute()
      : super(
          MainRoute.name,
          path: '/main',
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i9.ShopPage]
class ShopRoute extends _i42.PageRouteInfo<ShopRouteArgs> {
  ShopRoute({
    _i43.Key? key,
    required String shopId,
    String? productId,
    String? cartId,
    _i45.ShopData? shop,
    int? ownerId,
  }) : super(
          ShopRoute.name,
          path: '/shop',
          args: ShopRouteArgs(
            key: key,
            shopId: shopId,
            productId: productId,
            cartId: cartId,
            shop: shop,
            ownerId: ownerId,
          ),
        );

  static const String name = 'ShopRoute';
}

class ShopRouteArgs {
  const ShopRouteArgs({
    this.key,
    required this.shopId,
    this.productId,
    this.cartId,
    this.shop,
    this.ownerId,
  });

  final _i43.Key? key;

  final String shopId;

  final String? productId;

  final String? cartId;

  final _i45.ShopData? shop;

  final int? ownerId;

  @override
  String toString() {
    return 'ShopRouteArgs{key: $key, shopId: $shopId, productId: $productId, cartId: $cartId, shop: $shop, ownerId: $ownerId}';
  }
}

/// generated route for
/// [_i10.OrdersListPage]
class OrdersListRoute extends _i42.PageRouteInfo<void> {
  const OrdersListRoute()
      : super(
          OrdersListRoute.name,
          path: '/order',
        );

  static const String name = 'OrdersListRoute';
}

/// generated route for
/// [_i11.SettingPage]
class SettingRoute extends _i42.PageRouteInfo<void> {
  const SettingRoute()
      : super(
          SettingRoute.name,
          path: '/setting',
        );

  static const String name = 'SettingRoute';
}

/// generated route for
/// [_i12.OrderPage]
class OrderRoute extends _i42.PageRouteInfo<void> {
  const OrderRoute()
      : super(
          OrderRoute.name,
          path: '/orderScreen',
        );

  static const String name = 'OrderRoute';
}

/// generated route for
/// [_i13.SearchPage]
class SearchRoute extends _i42.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i43.Key? key,
    bool isBackButton = true,
  }) : super(
          SearchRoute.name,
          path: '/searchPage',
          args: SearchRouteArgs(
            key: key,
            isBackButton: isBackButton,
          ),
        );

  static const String name = 'SearchRoute';
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    this.isBackButton = true,
  });

  final _i43.Key? key;

  final bool isBackButton;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, isBackButton: $isBackButton}';
  }
}

/// generated route for
/// [_i14.ProfilePage]
class ProfileRoute extends _i42.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i43.Key? key,
    bool isBackButton = true,
  }) : super(
          ProfileRoute.name,
          path: '/ProfilePage',
          args: ProfileRouteArgs(
            key: key,
            isBackButton: isBackButton,
          ),
        );

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    this.isBackButton = true,
  });

  final _i43.Key? key;

  final bool isBackButton;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, isBackButton: $isBackButton}';
  }
}

/// generated route for
/// [_i15.ViewMapPage]
class ViewMapRoute extends _i42.PageRouteInfo<ViewMapRouteArgs> {
  ViewMapRoute({
    _i43.Key? key,
    bool isPop = true,
    bool isShopLocation = false,
    int? shopId,
    int? indexAddress,
    _i46.AddressNewModel? address,
  }) : super(
          ViewMapRoute.name,
          path: '/map',
          args: ViewMapRouteArgs(
            key: key,
            isPop: isPop,
            isShopLocation: isShopLocation,
            shopId: shopId,
            indexAddress: indexAddress,
            address: address,
          ),
        );

  static const String name = 'ViewMapRoute';
}

class ViewMapRouteArgs {
  const ViewMapRouteArgs({
    this.key,
    this.isPop = true,
    this.isShopLocation = false,
    this.shopId,
    this.indexAddress,
    this.address,
  });

  final _i43.Key? key;

  final bool isPop;

  final bool isShopLocation;

  final int? shopId;

  final int? indexAddress;

  final _i46.AddressNewModel? address;

  @override
  String toString() {
    return 'ViewMapRouteArgs{key: $key, isPop: $isPop, isShopLocation: $isShopLocation, shopId: $shopId, indexAddress: $indexAddress, address: $address}';
  }
}

/// generated route for
/// [_i16.StoryList]
class StoryList extends _i42.PageRouteInfo<StoryListArgs> {
  StoryList({
    _i43.Key? key,
    required int index,
    required _i47.RefreshController controller,
  }) : super(
          StoryList.name,
          path: '/storyList',
          args: StoryListArgs(
            key: key,
            index: index,
            controller: controller,
          ),
        );

  static const String name = 'StoryList';
}

class StoryListArgs {
  const StoryListArgs({
    this.key,
    required this.index,
    required this.controller,
  });

  final _i43.Key? key;

  final int index;

  final _i47.RefreshController controller;

  @override
  String toString() {
    return 'StoryListArgs{key: $key, index: $index, controller: $controller}';
  }
}

/// generated route for
/// [_i17.RecommendedPage]
class RecommendedRoute extends _i42.PageRouteInfo<RecommendedRouteArgs> {
  RecommendedRoute({
    _i43.Key? key,
    bool isNewsOfPage = false,
    bool isShop = false,
  }) : super(
          RecommendedRoute.name,
          path: '/recommended',
          args: RecommendedRouteArgs(
            key: key,
            isNewsOfPage: isNewsOfPage,
            isShop: isShop,
          ),
        );

  static const String name = 'RecommendedRoute';
}

class RecommendedRouteArgs {
  const RecommendedRouteArgs({
    this.key,
    this.isNewsOfPage = false,
    this.isShop = false,
  });

  final _i43.Key? key;

  final bool isNewsOfPage;

  final bool isShop;

  @override
  String toString() {
    return 'RecommendedRouteArgs{key: $key, isNewsOfPage: $isNewsOfPage, isShop: $isShop}';
  }
}

/// generated route for
/// [_i18.RecommendedOnePage]
class RecommendedOneRoute extends _i42.PageRouteInfo<RecommendedOneRouteArgs> {
  RecommendedOneRoute({
    _i43.Key? key,
    bool isNewsOfPage = false,
    bool isShop = false,
  }) : super(
          RecommendedOneRoute.name,
          path: '/recommended_one',
          args: RecommendedOneRouteArgs(
            key: key,
            isNewsOfPage: isNewsOfPage,
            isShop: isShop,
          ),
        );

  static const String name = 'RecommendedOneRoute';
}

class RecommendedOneRouteArgs {
  const RecommendedOneRouteArgs({
    this.key,
    this.isNewsOfPage = false,
    this.isShop = false,
  });

  final _i43.Key? key;

  final bool isNewsOfPage;

  final bool isShop;

  @override
  String toString() {
    return 'RecommendedOneRouteArgs{key: $key, isNewsOfPage: $isNewsOfPage, isShop: $isShop}';
  }
}

/// generated route for
/// [_i19.RecommendedTwoPage]
class RecommendedTwoRoute extends _i42.PageRouteInfo<RecommendedTwoRouteArgs> {
  RecommendedTwoRoute({
    _i43.Key? key,
    bool isNewsOfPage = false,
    bool isShop = false,
    bool isPopular = false,
  }) : super(
          RecommendedTwoRoute.name,
          path: '/recommended_two',
          args: RecommendedTwoRouteArgs(
            key: key,
            isNewsOfPage: isNewsOfPage,
            isShop: isShop,
            isPopular: isPopular,
          ),
        );

  static const String name = 'RecommendedTwoRoute';
}

class RecommendedTwoRouteArgs {
  const RecommendedTwoRouteArgs({
    this.key,
    this.isNewsOfPage = false,
    this.isShop = false,
    this.isPopular = false,
  });

  final _i43.Key? key;

  final bool isNewsOfPage;

  final bool isShop;

  final bool isPopular;

  @override
  String toString() {
    return 'RecommendedTwoRouteArgs{key: $key, isNewsOfPage: $isNewsOfPage, isShop: $isShop, isPopular: $isPopular}';
  }
}

/// generated route for
/// [_i20.MapSearchPage]
class MapSearchRoute extends _i42.PageRouteInfo<void> {
  const MapSearchRoute()
      : super(
          MapSearchRoute.name,
          path: '/map_search',
        );

  static const String name = 'MapSearchRoute';
}

/// generated route for
/// [_i21.HelpPage]
class HelpRoute extends _i42.PageRouteInfo<void> {
  const HelpRoute()
      : super(
          HelpRoute.name,
          path: '/help',
        );

  static const String name = 'HelpRoute';
}

/// generated route for
/// [_i22.OrderProgressPage]
class OrderProgressRoute extends _i42.PageRouteInfo<OrderProgressRouteArgs> {
  OrderProgressRoute({
    _i43.Key? key,
    num? orderId,
  }) : super(
          OrderProgressRoute.name,
          path: '/order_progress',
          args: OrderProgressRouteArgs(
            key: key,
            orderId: orderId,
          ),
        );

  static const String name = 'OrderProgressRoute';
}

class OrderProgressRouteArgs {
  const OrderProgressRouteArgs({
    this.key,
    this.orderId,
  });

  final _i43.Key? key;

  final num? orderId;

  @override
  String toString() {
    return 'OrderProgressRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [_i23.ResultFilter]
class ResultFilter extends _i42.PageRouteInfo<ResultFilterArgs> {
  ResultFilter({
    _i43.Key? key,
    required int categoryId,
  }) : super(
          ResultFilter.name,
          path: '/result_filter',
          args: ResultFilterArgs(
            key: key,
            categoryId: categoryId,
          ),
        );

  static const String name = 'ResultFilter';
}

class ResultFilterArgs {
  const ResultFilterArgs({
    this.key,
    required this.categoryId,
  });

  final _i43.Key? key;

  final int categoryId;

  @override
  String toString() {
    return 'ResultFilterArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i24.WalletHistory]
class WalletHistory extends _i42.PageRouteInfo<void> {
  const WalletHistory()
      : super(
          WalletHistory.name,
          path: '/wallet_history',
        );

  static const String name = 'WalletHistory';
}

/// generated route for
/// [_i25.CreateShop]
class CreateShop extends _i42.PageRouteInfo<void> {
  const CreateShop()
      : super(
          CreateShop.name,
          path: '/create_shop',
        );

  static const String name = 'CreateShop';
}

/// generated route for
/// [_i26.ShopsBannerPage]
class ShopsBannerRoute extends _i42.PageRouteInfo<ShopsBannerRouteArgs> {
  ShopsBannerRoute({
    _i43.Key? key,
    required int bannerId,
    required String title,
    bool isAds = false,
  }) : super(
          ShopsBannerRoute.name,
          path: '/shops_banner',
          args: ShopsBannerRouteArgs(
            key: key,
            bannerId: bannerId,
            title: title,
            isAds: isAds,
          ),
        );

  static const String name = 'ShopsBannerRoute';
}

class ShopsBannerRouteArgs {
  const ShopsBannerRouteArgs({
    this.key,
    required this.bannerId,
    required this.title,
    this.isAds = false,
  });

  final _i43.Key? key;

  final int bannerId;

  final String title;

  final bool isAds;

  @override
  String toString() {
    return 'ShopsBannerRouteArgs{key: $key, bannerId: $bannerId, title: $title, isAds: $isAds}';
  }
}

/// generated route for
/// [_i27.ShopDetailPage]
class ShopDetailRoute extends _i42.PageRouteInfo<ShopDetailRouteArgs> {
  ShopDetailRoute({
    _i43.Key? key,
    required _i45.ShopData shop,
    required String workTime,
  }) : super(
          ShopDetailRoute.name,
          path: '/shops_detail',
          args: ShopDetailRouteArgs(
            key: key,
            shop: shop,
            workTime: workTime,
          ),
        );

  static const String name = 'ShopDetailRoute';
}

class ShopDetailRouteArgs {
  const ShopDetailRouteArgs({
    this.key,
    required this.shop,
    required this.workTime,
  });

  final _i43.Key? key;

  final _i45.ShopData shop;

  final String workTime;

  @override
  String toString() {
    return 'ShopDetailRouteArgs{key: $key, shop: $shop, workTime: $workTime}';
  }
}

/// generated route for
/// [_i28.ShareReferralPage]
class ShareReferralRoute extends _i42.PageRouteInfo<void> {
  const ShareReferralRoute()
      : super(
          ShareReferralRoute.name,
          path: '/share_referral',
        );

  static const String name = 'ShareReferralRoute';
}

/// generated route for
/// [_i29.ShareReferralFaq]
class ShareReferralFaq extends _i42.PageRouteInfo<ShareReferralFaqArgs> {
  ShareReferralFaq({
    _i43.Key? key,
    required String terms,
  }) : super(
          ShareReferralFaq.name,
          path: '/share_referral_faq',
          args: ShareReferralFaqArgs(
            key: key,
            terms: terms,
          ),
        );

  static const String name = 'ShareReferralFaq';
}

class ShareReferralFaqArgs {
  const ShareReferralFaqArgs({
    this.key,
    required this.terms,
  });

  final _i43.Key? key;

  final String terms;

  @override
  String toString() {
    return 'ShareReferralFaqArgs{key: $key, terms: $terms}';
  }
}

/// generated route for
/// [_i30.ChatPage]
class ChatRoute extends _i42.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i43.Key? key,
    required String roleId,
    required String name,
  }) : super(
          ChatRoute.name,
          path: '/chat',
          args: ChatRouteArgs(
            key: key,
            roleId: roleId,
            name: name,
          ),
        );

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.roleId,
    required this.name,
  });

  final _i43.Key? key;

  final String roleId;

  final String name;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, roleId: $roleId, name: $name}';
  }
}

/// generated route for
/// [_i31.GenerateImagePage]
class GenerateImageRoute extends _i42.PageRouteInfo<void> {
  const GenerateImageRoute()
      : super(
          GenerateImageRoute.name,
          path: '/generate_image',
        );

  static const String name = 'GenerateImageRoute';
}

/// generated route for
/// [_i32.NotificationListPage]
class NotificationListRoute extends _i42.PageRouteInfo<void> {
  const NotificationListRoute()
      : super(
          NotificationListRoute.name,
          path: '/notification_list_page',
        );

  static const String name = 'NotificationListRoute';
}

/// generated route for
/// [_i33.ServiceTwoCategoryPage]
class ServiceTwoCategoryRoute
    extends _i42.PageRouteInfo<ServiceTwoCategoryRouteArgs> {
  ServiceTwoCategoryRoute({
    _i43.Key? key,
    required int index,
  }) : super(
          ServiceTwoCategoryRoute.name,
          path: '/service_two_category_page',
          args: ServiceTwoCategoryRouteArgs(
            key: key,
            index: index,
          ),
        );

  static const String name = 'ServiceTwoCategoryRoute';
}

class ServiceTwoCategoryRouteArgs {
  const ServiceTwoCategoryRouteArgs({
    this.key,
    required this.index,
  });

  final _i43.Key? key;

  final int index;

  @override
  String toString() {
    return 'ServiceTwoCategoryRouteArgs{key: $key, index: $index}';
  }
}

/// generated route for
/// [_i34.RecommendedThreePage]
class RecommendedThreeRoute
    extends _i42.PageRouteInfo<RecommendedThreeRouteArgs> {
  RecommendedThreeRoute({
    _i43.Key? key,
    bool isNewsOfPage = false,
    bool isShop = false,
    bool isPopular = false,
  }) : super(
          RecommendedThreeRoute.name,
          path: '/recommended_three',
          args: RecommendedThreeRouteArgs(
            key: key,
            isNewsOfPage: isNewsOfPage,
            isShop: isShop,
            isPopular: isPopular,
          ),
        );

  static const String name = 'RecommendedThreeRoute';
}

class RecommendedThreeRouteArgs {
  const RecommendedThreeRouteArgs({
    this.key,
    this.isNewsOfPage = false,
    this.isShop = false,
    this.isPopular = false,
  });

  final _i43.Key? key;

  final bool isNewsOfPage;

  final bool isShop;

  final bool isPopular;

  @override
  String toString() {
    return 'RecommendedThreeRouteArgs{key: $key, isNewsOfPage: $isNewsOfPage, isShop: $isShop, isPopular: $isPopular}';
  }
}

/// generated route for
/// [_i35.ParcelPage]
class ParcelRoute extends _i42.PageRouteInfo<void> {
  const ParcelRoute()
      : super(
          ParcelRoute.name,
          path: '/parcel_page',
        );

  static const String name = 'ParcelRoute';
}

/// generated route for
/// [_i36.InfoPage]
class InfoRoute extends _i42.PageRouteInfo<InfoRouteArgs> {
  InfoRoute({
    _i43.Key? key,
    required int index,
  }) : super(
          InfoRoute.name,
          path: '/info_screen',
          args: InfoRouteArgs(
            key: key,
            index: index,
          ),
        );

  static const String name = 'InfoRoute';
}

class InfoRouteArgs {
  const InfoRouteArgs({
    this.key,
    required this.index,
  });

  final _i43.Key? key;

  final int index;

  @override
  String toString() {
    return 'InfoRouteArgs{key: $key, index: $index}';
  }
}

/// generated route for
/// [_i37.LikePage]
class LikeRoute extends _i42.PageRouteInfo<LikeRouteArgs> {
  LikeRoute({
    _i43.Key? key,
    bool isBackButton = true,
  }) : super(
          LikeRoute.name,
          path: '/like_page',
          args: LikeRouteArgs(
            key: key,
            isBackButton: isBackButton,
          ),
        );

  static const String name = 'LikeRoute';
}

class LikeRouteArgs {
  const LikeRouteArgs({
    this.key,
    this.isBackButton = true,
  });

  final _i43.Key? key;

  final bool isBackButton;

  @override
  String toString() {
    return 'LikeRouteArgs{key: $key, isBackButton: $isBackButton}';
  }
}

/// generated route for
/// [_i38.ParcelListPage]
class ParcelListRoute extends _i42.PageRouteInfo<void> {
  const ParcelListRoute()
      : super(
          ParcelListRoute.name,
          path: '/parcel_list_page',
        );

  static const String name = 'ParcelListRoute';
}

/// generated route for
/// [_i39.ParcelProgressPage]
class ParcelProgressRoute extends _i42.PageRouteInfo<ParcelProgressRouteArgs> {
  ParcelProgressRoute({
    _i43.Key? key,
    num? parcelId,
  }) : super(
          ParcelProgressRoute.name,
          path: '/parcel_progress_page',
          args: ParcelProgressRouteArgs(
            key: key,
            parcelId: parcelId,
          ),
        );

  static const String name = 'ParcelProgressRoute';
}

class ParcelProgressRouteArgs {
  const ParcelProgressRouteArgs({
    this.key,
    this.parcelId,
  });

  final _i43.Key? key;

  final num? parcelId;

  @override
  String toString() {
    return 'ParcelProgressRouteArgs{key: $key, parcelId: $parcelId}';
  }
}

/// generated route for
/// [_i40.SubCategoryPage]
class SubCategoryRoute extends _i42.PageRouteInfo<SubCategoryRouteArgs> {
  SubCategoryRoute({
    _i43.Key? key,
    required _i45.CategoryData? category,
    required String shopId,
    required String? cartId,
  }) : super(
          SubCategoryRoute.name,
          path: '/sub_category_page',
          args: SubCategoryRouteArgs(
            key: key,
            category: category,
            shopId: shopId,
            cartId: cartId,
          ),
        );

  static const String name = 'SubCategoryRoute';
}

class SubCategoryRouteArgs {
  const SubCategoryRouteArgs({
    this.key,
    required this.category,
    required this.shopId,
    required this.cartId,
  });

  final _i43.Key? key;

  final _i45.CategoryData? category;

  final String shopId;

  final String? cartId;

  @override
  String toString() {
    return 'SubCategoryRouteArgs{key: $key, category: $category, shopId: $shopId, cartId: $cartId}';
  }
}

/// generated route for
/// [_i41.AddressListPage]
class AddressListRoute extends _i42.PageRouteInfo<void> {
  const AddressListRoute()
      : super(
          AddressListRoute.name,
          path: '/address_list_page',
        );

  static const String name = 'AddressListRoute';
}
