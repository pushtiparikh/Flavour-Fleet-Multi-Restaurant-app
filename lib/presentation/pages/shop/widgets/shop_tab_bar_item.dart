
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/infrastructure/models/models.dart';
import 'package:flavourfleet/presentation/components/buttons/animation_button_effect.dart';
import 'package:flavourfleet/presentation/components/custom_network_image.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

class ShopTabBarItem extends StatelessWidget {
  final String title;
  final String image;
  final CategoryData? category;
  final bool isActive;
  final VoidCallback? onTap;

  const ShopTabBarItem({
    Key? key,
    this.category,
    required this.isActive,
    this.onTap,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: AnimationButtonEffect(
        child: AnimatedContainer(
          height: 46.r,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isActive ? Style.brandGreen : Style.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            boxShadow: [
              BoxShadow(
                color: Style.white.withOpacity(0.07),
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
          margin: EdgeInsets.only(right: 9.w, top: 24.h),
          child: Row(
            children: [
              if (category?.img?.isNotEmpty ?? false)
                Padding(
                  padding: EdgeInsets.only(right: 6.r),
                  child: CustomNetworkImage(
                      url: category?.img ?? image,
                      height: 42,
                      width: 42,
                      radius: 2),
                ),
              Text(
                category?.translation?.title ?? title,
                style: Style.interNormal(
                  size: 13,
                  color: Style.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
