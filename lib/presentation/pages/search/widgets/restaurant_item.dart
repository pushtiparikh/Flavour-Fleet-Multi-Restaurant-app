import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/infrastructure/models/data/shop_data.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/shop_avarat.dart';
import 'package:flavourfleet/presentation/routes/app_router.gr.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

class RestaurantItem extends StatelessWidget {
  final ShopData shop;

  const RestaurantItem({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: () {
          context.pushRoute(
            ShopRoute(
              shopId: (shop.id ?? 0).toString(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            boxShadow: [
              BoxShadow(
                color: Style.white.withOpacity(0.04),
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              children: [
                ShopAvatar(
                  shopImage: shop.logoImg ?? "",
                  size: 50,
                  padding: 6,
                  bgColor: Style.blackWithOpacity,
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      shop.translation?.title ?? "",
                      style: Style.interSemi(
                        size: 15,
                        color: Style.black,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 200.h,
                      child: Text(
                        shop.bonus != null
                            ? ((shop.bonus?.type ?? "sum") == "sum")
                                ? "${AppHelpers.getTranslation(TrKeys.under)} ${AppHelpers.numberFormat(number: shop.bonus?.value)} + ${shop.bonus?.bonusStock?.product?.translation?.title ?? ""}"
                                : "${AppHelpers.getTranslation(TrKeys.under)} ${shop.bonus?.value ?? 0} + ${shop.bonus?.bonusStock?.product?.translation?.title ?? ""}"
                            : shop.translation?.description ?? "",
                        style: Style.interNormal(
                          size: 12,
                          color: Style.black,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
