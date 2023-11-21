import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flavourfleet/infrastructure/models/data/product_data.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/presentation/components/buttons/animation_button_effect.dart';
import 'package:flavourfleet/presentation/components/custom_network_image.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

import 'bonus_screen.dart';

class ShopProductItem extends StatelessWidget {
  final ProductData product;

  const ShopProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
                url: product.img ?? "",
                height: 100.h,
                width: double.infinity,
                radius: 0),
            8.verticalSpace,
            Text(
              product.translation?.title ?? "",
              style: Style.interNoSemi(
                size: 14,
                color: Style.black,
              ),
              maxLines: 2,
            ),
            Text(
              product.translation?.description ?? "",
              style: Style.interRegular(
                size: 12,
                color: Style.textGrey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppHelpers.numberFormat(
                          number: (product.stocks?.first.discount != null
                              ? ((product.stocks?.first.price ?? 0) +
                              (product.stocks?.first.tax ?? 0))
                              : null) ??
                              (product.stocks?.first.totalPrice ?? 0)),
                      style: Style.interNoSemi(
                          size: 16,
                          color: Style.black,
                          decoration: (product.stocks?.first.discount != null
                              ? ((product.stocks?.first.price ?? 0) +
                              (product.stocks?.first.tax ?? 0))
                              : null) ==
                              null
                              ? TextDecoration.none
                              : TextDecoration.lineThrough),
                    ),
                    (product.stocks?.first.discount != null
                        ? ((product.stocks?.first.price ?? 0) +
                        (product.stocks?.first.tax ?? 0))
                        : null) ==
                        null
                        ? const SizedBox.shrink()
                        : Container(
                      margin: EdgeInsets.only(top: 8.r),
                      decoration: BoxDecoration(
                          color: Style.redBg,
                          borderRadius: BorderRadius.circular(30.r)),
                      padding: EdgeInsets.all(4.r),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/svgs/discount.svg"),
                          8.horizontalSpace,
                          Text(
                            AppHelpers.numberFormat(
                                number:
                                (product.stocks?.first.totalPrice ??
                                    0)),
                            style: Style.interNoSemi(
                                size: 12, color: Style.red),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                product.stocks?.first.bonus != null
                    ? AnimationButtonEffect(
                  child: InkWell(
                    onTap: () {
                      AppHelpers.showCustomModalBottomSheet(
                        paddingTop: MediaQuery.of(context).padding.top,
                        context: context,
                        modal: BonusScreen(
                          bonus: product.stocks?.first.bonus,
                        ),
                        isDarkMode: false,
                        isDrag: true,
                        radius: 12,
                      );
                    },
                    child: Container(
                      width: 22.w,
                      height: 22.h,
                      margin: EdgeInsets.only(
                          top: 8.r, left: 8.r, right: 4.r, bottom: 4.r),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Style.blueBonus),
                      child: Icon(
                        FlutterRemix.gift_2_fill,
                        size: 16.r,
                        color: Style.white,
                      ),
                    ),
                  ),
                )
                    : const SizedBox.shrink()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
