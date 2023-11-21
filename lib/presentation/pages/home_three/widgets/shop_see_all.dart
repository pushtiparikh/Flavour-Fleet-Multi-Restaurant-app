import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/buttons/animation_button_effect.dart';
import 'package:flavourfleet/presentation/routes/app_router.gr.dart';
import 'package:flavourfleet/presentation/theme/app_style.dart';

class ShopSeeAll extends StatelessWidget {
  final int brandCount;

  const ShopSeeAll({super.key, required this.brandCount});

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      child: GestureDetector(
        onTap: () => context.pushRoute(RecommendedThreeRoute(isShop: true)),
        child: Stack(
          children: [
            Container(
              padding: REdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Style.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                    color: Style.outlineButtonBorder.withOpacity(0.5),
                    width: 1.2),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.seeAll),
                      style: Style.interNormal(size: 16),
                    ),
                    4.verticalSpace,
                    Text(
                      "$brandCount ${AppHelpers.getTranslation(TrKeys.brands)}",
                      style: Style.interNoSemi(size: 14, color: Style.textGrey),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                width: 36.r,
                height: 36.r,
                padding: REdgeInsets.all(4),
                decoration: ShapeDecoration(
                  shape: OvalBorder(
                    side: BorderSide(
                      width: 0.5,
                      color: Style.black.withOpacity(0.08),
                    ),
                  ),
                ),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 0.50,
                        color: Style.black.withOpacity(0.08),
                      ),
                    ),
                  ),
                  child: const Icon(
                    FlutterRemix.arrow_right_up_line,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
