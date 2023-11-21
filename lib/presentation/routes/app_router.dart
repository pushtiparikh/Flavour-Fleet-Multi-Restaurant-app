import 'package:auto_route/auto_route.dart';
import 'package:flavourfleet/presentation/pages/auth/login/login_page.dart';
import 'package:flavourfleet/presentation/pages/auth/confirmation/register_confirmation_page.dart';
import 'package:flavourfleet/presentation/pages/auth/register/register_page.dart';
import 'package:flavourfleet/presentation/pages/auth/reset/reset_password_page.dart';
import 'package:flavourfleet/presentation/pages/generate_image/generate_image_page.dart';
import 'package:flavourfleet/presentation/pages/home_one/widget/recommended_one_screen.dart';
import 'package:flavourfleet/presentation/pages/home_three/widgets/recommended_three_screen.dart';
import 'package:flavourfleet/presentation/pages/home_two/widget/recommended_two_screen.dart';
import 'package:flavourfleet/presentation/pages/initial/no_connection/no_connection_page.dart';
import 'package:flavourfleet/presentation/pages/initial/splash/splash_page.dart';
import 'package:flavourfleet/presentation/pages/initial/ui_type/ui_type_page.dart';
import 'package:flavourfleet/presentation/pages/like/like_page.dart';
import 'package:flavourfleet/presentation/pages/main/main_page.dart';
import 'package:flavourfleet/presentation/pages/order/order_screen/order_screen.dart';
import 'package:flavourfleet/presentation/pages/order/orders_page.dart';
import 'package:flavourfleet/presentation/pages/parcel/parcel_list_page.dart';
import 'package:flavourfleet/presentation/pages/parcel/parcel_order_page.dart';
import 'package:flavourfleet/presentation/pages/parcel/widgets/info_screen.dart';
import 'package:flavourfleet/presentation/pages/profile/address_list.dart';
import 'package:flavourfleet/presentation/pages/profile/notification_page.dart';
import 'package:flavourfleet/presentation/pages/profile/profile_page.dart';
import 'package:flavourfleet/presentation/pages/profile/wallet_history.dart';
import 'package:flavourfleet/presentation/pages/search/search_page.dart';
import 'package:flavourfleet/presentation/pages/service/service_two_category_page.dart';
import 'package:flavourfleet/presentation/pages/setting/setting_page.dart';
import 'package:flavourfleet/presentation/pages/shop/shop_detail.dart';
import 'package:flavourfleet/presentation/pages/shop/shop_page.dart';
import 'package:flavourfleet/presentation/pages/view_map/map_search_page.dart';
import 'package:flavourfleet/presentation/pages/view_map/view_map_page.dart';

import '../pages/chat/chat/chat_page.dart';
import '../pages/home/filter/result_filter.dart';
import '../pages/home/widgets/shops_banner_page.dart';
import '../pages/order/order_screen/order_progress_screen.dart';
import '../pages/parcel/parcel_page.dart';
import '../pages/profile/become_seller/create_shop.dart';
import '../pages/profile/help_page.dart';
import '../pages/home/widgets/recommended_screen.dart';
import '../pages/profile/share_referral_faq.dart';
import '../pages/profile/share_referral_page.dart';
import '../pages/shop/sub_category_screen.dart';
import '../pages/story_page/story_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    MaterialRoute(
      path: '/',
      page: SplashPage,
    ),
    MaterialRoute(
      path: '/no-connection',
      page: NoConnectionPage,
    ),
    MaterialRoute(
      path: '/login',
      page: LoginPage,
    ),
    MaterialRoute(
      path: '/ui-type',
      page: UiTypePage,
    ),
    MaterialRoute(
      path: '/reset',
      page: ResetPasswordPage,
    ),
    MaterialRoute(
      path: '/register-confirmation',
      page: RegisterConfirmationPage,
    ),
    MaterialRoute(
      path: '/register',
      page: RegisterPage,
    ),
    MaterialRoute(
      path: '/main',
      page: MainPage,
    ),
    MaterialRoute(
      path: '/shop',
      page: ShopPage,
    ),
    MaterialRoute(
      path: '/order',
      page: OrdersListPage,
    ),
    MaterialRoute(
      path: '/setting',
      page: SettingPage,
    ),
    MaterialRoute(
      path: '/orderScreen',
      page: OrderPage,
    ),
    MaterialRoute(
      path: '/searchPage',
      page: SearchPage,
    ),
    MaterialRoute(
      path: '/ProfilePage',
      page: ProfilePage,
    ),
    MaterialRoute(
      path: '/map',
      page: ViewMapPage,
    ),
    MaterialRoute(
      path: "/storyList",
      page: StoryList,
    ),
    MaterialRoute(
      path: '/recommended',
      page: RecommendedPage,
    ),
    MaterialRoute(
      path: '/recommended_one',
      page: RecommendedOnePage,
    ),
    MaterialRoute(
      path: '/recommended_two',
      page: RecommendedTwoPage,
    ),
    MaterialRoute(
      path: '/map_search',
      page: MapSearchPage,
    ),
    MaterialRoute(
      path: '/help',
      page: HelpPage,
    ),
    MaterialRoute(
      path: '/order_progress',
      page: OrderProgressPage,
    ),
    MaterialRoute(
      path: '/result_filter',
      page: ResultFilter,
    ),
    MaterialRoute(
      path: '/wallet_history',
      page: WalletHistory,
    ),
    MaterialRoute(
      path: '/create_shop',
      page: CreateShop,
    ),
    MaterialRoute(
      path: '/shops_banner',
      page: ShopsBannerPage,
    ),
    MaterialRoute(
      path: '/shops_detail',
      page: ShopDetailPage,
    ),
    MaterialRoute(
      path: '/share_referral',
      page: ShareReferralPage,
    ),
    MaterialRoute(
      path: '/share_referral_faq',
      page: ShareReferralFaq,
    ),
    MaterialRoute(
      path: '/chat',
      page: ChatPage,
    ),
    MaterialRoute(
      path: '/generate_image',
      page: GenerateImagePage,
    ),
    MaterialRoute(
      path: '/notification_list_page',
      page: NotificationListPage,
    ),
    MaterialRoute(
      path: '/service_two_category_page',
      page: ServiceTwoCategoryPage,
    ),
    MaterialRoute(
      path: '/recommended_three',
      page: RecommendedThreePage,
    ),
    MaterialRoute(
      path: '/parcel_page',
      page: ParcelPage,
    ),
    MaterialRoute(
      path: '/info_screen',
      page: InfoPage,
    ),
    MaterialRoute(
      path: '/like_page',
      page: LikePage,
    ),
    MaterialRoute(
      path: '/parcel_list_page',
      page: ParcelListPage,
    ),
    MaterialRoute(
      path: '/parcel_progress_page',
      page: ParcelProgressPage,
    ),
    MaterialRoute(
      path: '/sub_category_page',
      page: SubCategoryPage,
    ),
    MaterialRoute(
      path: '/address_list_page',
      page: AddressListPage,
    ),
  ],
)
class $AppRouter {}
