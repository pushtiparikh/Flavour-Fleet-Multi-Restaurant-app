import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/infrastructure/models/models.dart';
import 'package:flavourfleet/presentation/components/buttons/animation_button_effect.dart';
import 'package:flavourfleet/presentation/components/custom_network_image.dart';
import 'package:flavourfleet/presentation/theme/app_style.dart';

class ServiceTwoCategoriesItem extends StatelessWidget {
  final CategoryData category;
  final VoidCallback onTap;
  const ServiceTwoCategoriesItem({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  AnimationButtonEffect(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: REdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomNetworkImage(
                    url: category.img ?? "",
                    height: 80.h,
                    width: 80.w,
                    radius: 12.r,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Text(
                category.translation?.title ?? "",
                style: Style.interNormal(
                  size: 14,
                ),
                maxLines: 1,
              ),
              const Spacer(),

            ],
          ),
        ),
      ),
    );
  }
}
