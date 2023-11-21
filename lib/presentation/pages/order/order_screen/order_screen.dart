// ignore_for_file: unused_result

import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as l;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flavourfleet/application/order/order_provider.dart';
import 'package:flavourfleet/application/order/order_state.dart';
import 'package:flavourfleet/infrastructure/services/app_constants.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/local_storage.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/app_bars/common_app_bar.dart';
import 'package:flavourfleet/presentation/components/buttons/pop_button.dart';
import 'package:flavourfleet/presentation/components/keyboard_dismisser.dart';
import 'package:flavourfleet/presentation/components/loading.dart';
import 'package:flavourfleet/presentation/components/shop_avarat.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';
import '../../../../application/payment_methods/payment_provider.dart';
import '../../../../application/shop_order/shop_order_provider.dart';
import '../order_check/order_check.dart';
import '../order_type/widgets/order_map.dart';
import '../order_type/order_type.dart';
import '../order_check/widgets/rating_page.dart';
import 'widgets/order_carts.dart';
import 'widgets/order_status.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage>
    with SingleTickerProviderStateMixin {
  late RefreshController refreshController;
  late TabController _tabController;
  late ConfettiController _controllerCenter;
  late double long;
  late double lat;
  int tabIndex = 0;

  void getAddress() {
    long = LocalStorage.getAddressSelected()?.location?.longitude ??
        AppConstants.demoLongitude;
    lat = LocalStorage.getAddressSelected()?.location?.latitude ??
        AppConstants.demoLatitude;
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 2));
    refreshController = RefreshController();
    if (ref.read(shopOrderProvider).cart != null) {
      _tabController.addListener(() {
        ref.read(orderProvider.notifier).changeTabIndex(_tabController.index);
        if (_tabController.index == 1) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(orderProvider.notifier).getCalculate(
                isLoading: false,
                context: context,
                cartId: ref.read(shopOrderProvider).cart?.id ?? 0,
                long: long,
                lat: lat,
                type: DeliveryTypeEnum.pickup);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(orderProvider.notifier).getCalculate(
                isLoading: false,
                context: context,
                cartId: ref.read(shopOrderProvider).cart?.id ?? 0,
                long: long,
                lat: lat,
                type: DeliveryTypeEnum.delivery);
          });
        }
      });
      getAddress();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(shopOrderProvider.notifier).getCart(context, () {});
        ref.read(orderProvider.notifier)
          ..resetState()
          ..fetchShop(context,
              (ref.watch(shopOrderProvider).cart?.shopId ?? 0).toString())
          ..fetchShopBranch(context,
              (ref.watch(shopOrderProvider).cart?.shopId ?? 0).toString())
          ..getCalculate(
            context: context,
            cartId: ref.watch(shopOrderProvider).cart?.id ?? 0,
            long: long,
            lat: lat,
            type: DeliveryTypeEnum.delivery,
          );
        ref.refresh(paymentProvider);
        ref.read(paymentProvider.notifier).fetchPayments(context);
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = LocalStorage.getAppThemeMode();
    final isLtr = LocalStorage.getLangLtr();
    final state = ref.watch(orderProvider);
    final event = ref.read(orderProvider.notifier);
    ref.listen(orderProvider, (previous, next) {
      if (AppHelpers.getOrderStatus(next.orderData?.status ?? "") ==
          OrderStatus.delivered) {
        AppHelpers.showCustomModalBottomSheet(
          context: context,
          modal: const RatingPage(),
          isDarkMode: isDarkMode,
        );
      }
    });
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: KeyboardDismisser(
        child: ConfettiWidget(
          blastDirectionality: BlastDirectionality.explosive,
          confettiController: _controllerCenter,
          particleDrag: 0.02,
          emissionFrequency: 0.02,
          numberOfParticles: 45,
          gravity: 0.1,
          shouldLoop: false,
          displayTarget: true,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: isDarkMode ? Style.mainBackDark : Style.bgGrey,
            body: !(!(ref.watch(shopOrderProvider).cart == null ||
                        (ref
                                .watch(shopOrderProvider)
                                .cart
                                ?.userCarts
                                ?.isEmpty ??
                            true) ||
                        ((ref
                                        .watch(shopOrderProvider)
                                        .cart
                                        ?.userCarts
                                        ?.isEmpty ??
                                    true)
                                ? true
                                : (ref
                                        .watch(shopOrderProvider)
                                        .cart
                                        ?.userCarts
                                        ?.first
                                        .cartDetails
                                        ?.isEmpty ??
                                    true)) &&
                            !(ref.watch(shopOrderProvider).cart?.group ??
                                false)) ||
                    state.orderData != null)
                ? _resultEmpty()
                : state.isLoading
                    ? const Loading()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _appBar(context, state),
                          Expanded(
                            child: SmartRefresher(
                              enablePullDown: state.orderData != null,
                              enablePullUp: false,
                              controller: state.orderData == null
                                  ? RefreshController()
                                  : refreshController,
                              onRefresh: () {
                                event.showOrder(
                                      context, state.orderData?.id ?? 0, true);
                                refreshController.refreshCompleted();
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    16.verticalSpace,
                                    state.orderData != null
                                        ? OrderMap(
                                            isLoading: state.isMapLoading,
                                            polylineCoordinates:
                                                state.polylineCoordinates,
                                            markers: Set<Marker>.of(
                                                state.markers.values),
                                            latLng: LatLng(
                                                state.orderData?.shop?.location
                                                        ?.latitude ??
                                                    0,
                                                state.orderData?.shop?.location
                                                        ?.longitude ??
                                                    0),
                                          )
                                        : OrderType(
                                            sendUser: ref
                                                .watch(orderProvider)
                                                .sendOtherUser,
                                            shopId: state.shopData?.id ?? 0,
                                            tabController: _tabController,
                                            onChange: (s) =>
                                                event.changeActive(s),
                                            getLocation: () {
                                              getAddress();
                                              event.getCalculate(
                                                isLoading: false,
                                                context: context,
                                                cartId: ref
                                                        .read(shopOrderProvider)
                                                        .cart
                                                        ?.id ??
                                                    0,
                                                long: long,
                                                lat: lat,
                                                type: _tabController.index == 0
                                                    ? DeliveryTypeEnum.delivery
                                                    : DeliveryTypeEnum.pickup,
                                              );
                                            },
                                          ),
                                    Stack(
                                      children: [
                                        OrderCarts(
                                          lat: lat,
                                          long: long,
                                          tabBarIndex: _tabController.index,
                                        ),
                                        if (ref
                                            .watch(shopOrderProvider)
                                            .isAddAndRemoveLoading)
                                          _customLoading(),
                                      ],
                                    ),
                                    OrderCheck(
                                      orderStatus: AppHelpers.getOrderStatus(
                                          state.orderData?.status ?? ""),
                                      isOrder: state.orderData != null,
                                      isActive: state.isActive,
                                      controllerCenter: _controllerCenter,
                                    ),
                                    42.verticalSpace
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: const PopButton(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _resultEmpty() {
    return Column(
      children: [
        100.verticalSpace,
        l.Lottie.asset('assets/lottie/girl_empty.json'),
        24.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.cartIsEmpty),
          style: Style.interSemi(size: 18.sp),
        ),
      ],
    );
  }

  CommonAppBar _appBar(BuildContext context, OrderState state) {
    return CommonAppBar(
      height: state.orderData != null ? 170 : 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ShopAvatar(
                shopImage: state.orderData == null
                    ? (state.shopData?.logoImg ?? "")
                    : (state.orderData?.shop?.logoImg ?? ""),
                size: 40,
                padding: 4,
                radius: 8,
                bgColor: Style.black.withOpacity(0.06),
              ),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    state.orderData == null
                        ? (state.shopData?.translation?.title ?? "")
                        : (state.orderData?.shop?.translation?.title ?? ""),
                    style: Style.interSemi(
                      size: 16,
                      color: Style.black,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 86.h,
                    child: Text(
                      state.orderData == null
                          ? (state.shopData?.translation?.description ?? "")
                          : (state.orderData?.shop?.translation?.description ??
                              ""),
                      style: Style.interNormal(
                        size: 12,
                        color: Style.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          state.orderData != null
              ? OrderStatusScreen(
                  status:
                      AppHelpers.getOrderStatus(state.orderData?.status ?? ""),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

Widget _customLoading() {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
    child: Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Style.white.withOpacity(0.5),
      ),
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: const Loading(),
      ),
    ),
  );
}
