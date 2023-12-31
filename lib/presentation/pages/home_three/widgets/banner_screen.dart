import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/infrastructure/models/data/shop_data.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/buttons/custom_button.dart';
import 'package:flavourfleet/presentation/components/custom_network_image.dart';
import 'package:flavourfleet/presentation/routes/app_router.gr.dart';

import '../../../../infrastructure/services/app_helpers.dart';
import '../../../theme/app_style.dart';

class BannerScreen extends StatelessWidget {
  final String image;
  final int bannerId;
  final String desc;
  final List<ShopData> list;

  const BannerScreen(
      {Key? key, required this.image, required this.desc, required this.list, required this.bannerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 192.h,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
              child: CustomNetworkImage(
                url: image,
                height: double.infinity,
                width: double.infinity,
                radius: 0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Text(
              desc,
              style: Style.interRegular(size: 14.sp, color: Style.textGrey),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                      background: Style.transparent,
                      borderColor: Style.tabBarBorderColor,
                      title: AppHelpers.getTranslation(TrKeys.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                10.horizontalSpace,
                Expanded(
                  child: CustomButton(
                      title: AppHelpers.getTranslation(TrKeys.orderNow),
                      onPressed: () {
                        context.pushRoute(
                            ShopsBannerRoute(bannerId: bannerId, title: desc));
                      }),
                ),
              ],
            ),
          ),
          16.verticalSpace
        ],
      ),
    );
  }
}
