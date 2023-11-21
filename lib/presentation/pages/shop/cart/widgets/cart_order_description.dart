import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

class ShopOrderDescription extends StatelessWidget {
  final String svgName;
  final String title;
  final String description;
  final num price;
  final double iconSize;
  final bool discount;

  const ShopOrderDescription({
    Key? key,
    required this.price,
    required this.svgName,
    required this.title,
    required this.description,
    this.iconSize = 24,
    this.discount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          svgName,
          width: iconSize.r,
          height: iconSize.r,
        ),
        12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Style.interNormal(
                  size: 16,
                  color: Style.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                description,
                style: Style.interNormal(
                  size: 12,
                  color: Style.textGrey,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          discount
              ? "-${AppHelpers.numberFormat(number: price)}"
              : AppHelpers.numberFormat(number: price),
          style: Style.interSemi(
            size: 16.sp,
            color: discount ? Style.red : Style.black,
          ),
        ),
      ],
    );
  }
}
