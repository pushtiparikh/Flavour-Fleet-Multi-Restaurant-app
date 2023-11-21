import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flavourfleet/presentation/components/title_icon.dart';

import '../../../../infrastructure/services/app_helpers.dart';
import '../../../../infrastructure/services/tr_keys.dart';
import 'market_shimmer_three.dart';

class AllShopShimmer extends StatelessWidget {
  final bool isTitle;

  const AllShopShimmer({Key? key, this.isTitle = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isTitle
            ? TitleAndIcon(
                title: AppHelpers.getTranslation(TrKeys.allRestaurants),
              )
            : const SizedBox.shrink(),
        AnimationLimiter(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 6.h),
            shrinkWrap: true,
            
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 2,
            itemBuilder: (context, index) =>
                AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: const SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: MarketShimmerThree(
                    isSimpleShop: true,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
