import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flavourfleet/infrastructure/models/data/parcel_order.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/routes/app_router.gr.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

import '../../../../infrastructure/services/app_constants.dart';
import 'package:intl/intl.dart' as intl;

class ParcelItem extends StatelessWidget {
  final ParcelOrder? parcel;
  final bool isActive;

  const ParcelItem({
    Key? key,
    required this.isActive,
    this.parcel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(
          ParcelProgressRoute(
            parcelId: (parcel?.id ?? 0),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 36.h,
                  width: 36.w,
                  decoration: BoxDecoration(
                    color: (isActive ? Style.brandGreen : Style.bgGrey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: isActive
                        ? Stack(
                            children: [
                              Center(
                                  child: SvgPicture.asset(
                                      "assets/svgs/orderTime.svg")),
                              Center(
                                child: Text(
                                  "15",
                                  style: Style.interNoSemi(
                                    size: 10,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Icon(
                            AppHelpers.getOrderStatus(parcel?.status ?? "") ==
                                    OrderStatus.delivered
                                ? Icons.done_all
                                : Icons.cancel_outlined,
                            size: 16.r,
                          ),
                  ),
                ),
                10.horizontalSpace,
                Text(
                  "#${AppHelpers.getTranslation(TrKeys.id)}${parcel?.id}",
                  style: Style.interNoSemi(
                    size: 16,
                  ),
                )
              ],
            ),
            22.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppHelpers.numberFormat(
                          isOrder: parcel?.currency?.symbol != null,
                          symbol: parcel?.currency?.symbol,
                          number: (parcel?.totalPrice?.isNegative ?? true)
                              ? 0
                              : (parcel?.totalPrice ?? 0)),
                      style: Style.interNoSemi(
                        size: 16,
                      ),
                    ),
                    Text(
                      intl.DateFormat("MMM dd, HH:mm")
                          .format(parcel?.createdAt ?? DateTime.now()),
                      style: Style.interRegular(
                        size: 12,
                      ),
                    )
                  ],
                ),
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: const BoxDecoration(
                      color: Style.enterOrderButton, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
