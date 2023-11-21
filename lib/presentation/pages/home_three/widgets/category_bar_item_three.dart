import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/presentation/components/custom_network_image.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

class CategoryBarItemThree extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  const CategoryBarItemThree(
      {Key? key,
      required this.image,
      required this.title,
      this.isActive = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 8.r),
        height: 40.h,
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: isActive ? Style.brandGreen : Style.bgGrey),
        child: InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomNetworkImage(
                url: image,
                height: 32.r,
                width: 32.r,
                radius: 0,
                fit: BoxFit.cover,
              ),
              6.horizontalSpace,
              Text(
                title,
                style: Style.interNormal(
                  size: 12,
                  color: Style.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
