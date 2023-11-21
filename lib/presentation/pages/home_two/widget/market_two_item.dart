import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flavourfleet/infrastructure/models/data/shop_data.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/badge_item.dart';
import 'package:flavourfleet/presentation/components/custom_network_image.dart';
import 'package:flavourfleet/presentation/routes/app_router.gr.dart';

import '../../../theme/app_style.dart';
import 'two_bonus_discount.dart';

class MarketTwoItem extends StatelessWidget {
  final ShopData shop;
  final bool isSimpleShop;
  final bool isShop;
  final bool isFilter;

  const MarketTwoItem({
    Key? key,
    this.isSimpleShop = false,
    required this.shop,
    this.isShop = false,
    this.isFilter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(
            ShopRoute(shopId: (shop.id ?? 0).toString(), shop: shop));
      },
      child: isShop
          ? _shopItem()
          : Container(
              margin: isFilter
                  ? REdgeInsets.symmetric(horizontal: 16)
                  : isSimpleShop
                      ? EdgeInsets.all(8.r)
                      : EdgeInsets.only(right: 8.r),
              width: 268.w,
              decoration: BoxDecoration(
                  color: Style.white,
                  borderRadius: BorderRadius.all(Radius.circular(24.r))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Style.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.r),
                            topRight: Radius.circular(24.r),
                          ),
                        ),
                        width: double.infinity,
                        height: 150.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.r),
                              topRight: Radius.circular(24.r)),
                          child: CustomNetworkImage(
                            url: shop.backgroundImg ?? '',
                            height: isSimpleShop ? 140.h : 150.h,
                            width: double.infinity,
                            radius: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10.h,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding:
                              EdgeInsets.only(bottom: isSimpleShop ? 6.h : 0),
                          child: TwoBonusDiscountPopular(
                              isPopular: shop.isRecommend ?? false,
                              bonus: shop.bonus,
                              isDiscount: shop.isDiscount ?? false),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: REdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: ShapeDecoration(
                            color: Style.white.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100.r),
                                bottomLeft: Radius.circular(100.r),
                                topRight: Radius.circular(100.r),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/delivery_time.svg",
                                height: 24.r,
                              ),
                              4.horizontalSpace,
                              Text(
                                "${shop.deliveryTime?.from ?? 0} - ${shop.deliveryTime?.to ?? 0} ${shop.deliveryTime?.type ?? "min"}",
                                style: Style.interNormal(
                                  size: 12,
                                  color: Style.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 50.r,
                                    child: Text(
                                      shop.translation?.title ?? "",
                                      style: Style.interSemi(
                                        size: 16,
                                        color: Style.black,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  if (shop.verify ?? false)
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.r),
                                      child: const BadgeItem(),
                                    ),
                                ],
                              ),
                              4.verticalSpace,
                              Text(
                                shop.bonus != null
                                    ? ((shop.bonus?.type ?? "sum") == "sum")
                                        ? "${AppHelpers.getTranslation(TrKeys.under)} ${AppHelpers.numberFormat(
                                            number: shop.bonus?.value,
                                          )} + ${shop.bonus?.bonusStock?.product?.translation?.title ?? ""}"
                                        : "${AppHelpers.getTranslation(TrKeys.under)} ${shop.bonus?.value ?? 0} + ${shop.bonus?.bonusStock?.product?.translation?.title ?? ""}"
                                    : shop.translation?.description ?? "",
                                style: Style.interNormal(
                                  size: 12,
                                  color: Style.black,
                                ),
                                maxLines: isSimpleShop ? 2 : 1,
                              ),
                              6.verticalSpace,
                            ],
                          ),
                        ),
                        10.horizontalSpace,
                        SvgPicture.asset("assets/svgs/star.svg"),
                        4.horizontalSpace,
                        Text(
                          (shop.avgRate ?? ""),
                          style: Style.interNormal(
                            size: 12.sp,
                            color: Style.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _shopItem() {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Style.bgGrey,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          24.verticalSpace,
          CustomNetworkImage(
            url: shop.logoImg ?? "",
            height: 80.r,
            width: 80.r,
            radius: 40.r,
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                shop.translation?.title ?? "",
                style: Style.interSemi(
                  size: 14,
                  color: Style.black,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              if (shop.verify ?? false)
                Padding(
                  padding: EdgeInsets.only(left: 4.r),
                  child: const BadgeItem(),
                ),
            ],
          ),
          6.verticalSpace,
          Text(
            "${shop.deliveryTime?.from ?? 0} - ${shop.deliveryTime?.to ?? 0} ${shop.deliveryTime?.type ?? "min"}",
            style: Style.interSemi(
              size: 12,
              color: Style.textGrey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          28.verticalSpace,
        ],
      ),
    );
  }
}
