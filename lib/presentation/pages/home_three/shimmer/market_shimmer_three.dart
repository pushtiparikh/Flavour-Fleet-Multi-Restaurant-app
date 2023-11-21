import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_style.dart';

class MarketShimmerThree extends StatelessWidget {
  final bool isSimpleShop;
  final bool isShop;

  const MarketShimmerThree(
      {Key? key,
      this.isSimpleShop = false,
      this.isShop = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isShop
        ? Container(
            margin: EdgeInsets.only(right: 8.r),
            width: 134.w,
            height: 130.h,
            decoration: BoxDecoration(
                color: Style.shimmerBase,
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
          )
        : Container(
            margin: isSimpleShop
                ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h)
                : EdgeInsets.only(right: 8.r),
            width: 268.w,
            height: 260.h,
            decoration: BoxDecoration(
                color: Style.shimmerBase,
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
          );
  }
}
