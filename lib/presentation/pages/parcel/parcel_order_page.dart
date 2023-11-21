import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flavourfleet/application/parcel/parcel_notifier.dart';
import 'package:flavourfleet/application/parcel/parcel_provider.dart';
import 'package:flavourfleet/application/parcel/parcel_state.dart';
import 'package:flavourfleet/infrastructure/services/app_constants.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/local_storage.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/app_bars/common_app_bar.dart';
import 'package:flavourfleet/presentation/components/buttons/pop_button.dart';
import 'package:flavourfleet/presentation/components/keyboard_dismisser.dart';
import 'package:flavourfleet/presentation/components/loading.dart';
import 'package:flavourfleet/presentation/pages/order/order_check/widgets/rating_page.dart';
import 'package:flavourfleet/presentation/pages/order/order_check/widgets/title_price.dart';
import 'package:flavourfleet/presentation/pages/order/order_screen/widgets/order_status.dart';
import 'package:flavourfleet/presentation/pages/order/order_type/widgets/order_map.dart';
import 'package:flavourfleet/presentation/theme/app_style.dart';

class ParcelProgressPage extends ConsumerStatefulWidget {
  final num? parcelId;

  const ParcelProgressPage({
    Key? key,
    this.parcelId,
  }) : super(key: key);

  @override
  ConsumerState<ParcelProgressPage> createState() => _ParcelProgressPageState();
}

class _ParcelProgressPageState extends ConsumerState<ParcelProgressPage> {
  RefreshController refreshController = RefreshController();
  late ParcelNotifier event;
  late bool isLtr;
  Timer? timer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(parcelProvider.notifier)
          .showParcel(context, widget.parcelId ?? 0, false);
    });
    timer = Timer.periodic(const Duration(seconds: 120), (Timer t) {
      ref
          .read(parcelProvider.notifier)
          .showParcel(context, widget.parcelId ?? 0, true);
    });
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(parcelProvider);
    final event = ref.read(parcelProvider.notifier);
    final isLtr = LocalStorage.getLangLtr();
    ref.listen(parcelProvider, (previous, next) {
      if (AppHelpers.getOrderStatus(next.parcel?.status ?? "") ==
          OrderStatus.delivered &&
          next.parcel?.review == null &&
          previous?.parcel?.status != next.parcel?.status) {
        AppHelpers.showCustomModalBottomSheet(
          context: context,
          modal:   const RatingPage(parcel: true,),
          isDarkMode: false,
        );
      }
    });
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: KeyboardDismisser(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Style.bgGrey,
          body: state.isLoading
              ? const Loading()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _appBar(context, state),
                    Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: false,
                        controller: refreshController,
                        onRefresh: () {
                          event.showParcel(
                              context, state.parcel?.id ?? 0, true);
                          refreshController.refreshCompleted();
                        },
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.r, horizontal: 16.r),
                          child: Column(
                            children: [
                              OrderMap(
                                isLoading: state.isMapLoading,
                                polylineCoordinates: state.polylineCoordinates,
                                markers: Set<Marker>.of(state.markers.values),
                                latLng: LatLng(
                                    state.parcel?.addressFrom?.latitude ?? 0,
                                    state.parcel?.addressFrom?.longitude ?? 0),
                              ),
                              24.verticalSpace,
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Style.white,
                                    borderRadius: BorderRadius.circular(10.r)),
                                padding: EdgeInsets.all(16.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppHelpers.getTranslation(
                                          TrKeys.parcelDetail),
                                      style: Style.interSemi(),
                                    ),
                                    24.verticalSpace,
                                    Text(
                                      AppHelpers.getTranslation(TrKeys.type),
                                      style: Style.interNoSemi(
                                          color: Style.textGrey, size: 16),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      state.parcel?.type?.type ?? "",
                                      style: Style.interNoSemi(size: 16),
                                    ),
                                    16.verticalSpace,
                                    Text(
                                      AppHelpers.getTranslation(
                                          TrKeys.receiver),
                                      style: Style.interNoSemi(
                                          color: Style.textGrey, size: 16),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      state.parcel?.usernameTo ?? "",
                                      style: Style.interNoSemi(size: 16),
                                    ),
                                    16.verticalSpace,
                                    Text(
                                      AppHelpers.getTranslation(
                                          TrKeys.phoneNumber),
                                      style: Style.interNoSemi(
                                          color: Style.textGrey, size: 16),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      state.parcel?.phoneTo ?? "",
                                      style: Style.interNoSemi(size: 16),
                                    ),
                                    16.verticalSpace,
                                    Text(
                                      AppHelpers.getTranslation(
                                          TrKeys.comment),
                                      style: Style.interNoSemi(
                                          color: Style.textGrey, size: 16),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      state.parcel?.note ?? "",
                                      style: Style.interNoSemi(size: 16),
                                    ),
                                    16.verticalSpace
                                  ],
                                ),
                              ),
                              24.verticalSpace,
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Style.white,
                                    borderRadius: BorderRadius.circular(10.r)),
                                padding: EdgeInsets.all(16.r),
                                child:    Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppHelpers.getTranslation(TrKeys.order),
                                      style: Style.interNoSemi(
                                        size: 16,
                                        color: Style.black,
                                      ),
                                    ),
                                    8.verticalSpace,
                                    Row(
                                      children: [
                                        Text(
                                          "#${AppHelpers.getTranslation(TrKeys.id)}${state.parcel?.id ?? 0}",
                                          style: Style.interNormal(
                                            size: 14,
                                            color: Style.textGrey,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                                          width: 6.w,
                                          height: 6.h,
                                          decoration: const BoxDecoration(
                                              color: Style.textGrey, shape: BoxShape.circle),
                                        ),
                                        Text(
                                          intl.DateFormat("MMM dd, HH:mm").format(state.parcel?.createdAt ?? DateTime.now()),
                                          style: Style.interNormal(
                                            size: 14,
                                            color: Style.textGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    16.verticalSpace,
                                    const Divider(
                                      color: Style.textGrey,
                                    ),
                                    16.verticalSpace,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppHelpers.getTranslation(TrKeys.deliveryAddress),
                                          style: Style.interRegular(
                                            size: 14,
                                            color: Style.textGrey,
                                          ),
                                        ),
                                        Text(
                                          state.parcel?.addressTo?.address ?? "",
                                          style: Style.interNoSemi(
                                            size: 16,
                                            color: Style.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    16.verticalSpace,
                                    const Divider(
                                      color: Style.textGrey,
                                    ),
                                    16.verticalSpace,
                                    TitleAndPrice(
                                      title: AppHelpers.getTranslation(TrKeys.total),
                                      rightTitle: AppHelpers.numberFormat(
                                        isOrder: true,
                                        symbol: state.parcel?.currency?.symbol,
                                        number:  state.parcel?.totalPrice,
                                      ),
                                      textStyle: Style.interSemi(
                                        size: 20,
                                        color: Style.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              100.verticalSpace
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: const PopButton(),
          ),
        ),
      ),
    );
  }

  CommonAppBar _appBar(BuildContext context, ParcelState state) {
    return CommonAppBar(
      height: 170,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                state.parcel?.usernameFrom ?? "",
                style: Style.interSemi(
                  size: 16,
                  color: Style.black,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 98.w,
                child: Text(
                  state.parcel?.addressFrom?.address ?? "",
                  style: Style.interNormal(
                    size: 12,
                    color: Style.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          OrderStatusScreen(
            status: AppHelpers.getOrderStatus(state.parcel?.status ?? ""),
            parcel: true,
          )
        ],
      ),
    );
  }
}
