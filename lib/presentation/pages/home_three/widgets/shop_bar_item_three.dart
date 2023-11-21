import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flavourfleet/infrastructure/models/data/story_data.dart';
import 'package:flavourfleet/presentation/components/custom_network_image.dart';
import 'package:flavourfleet/presentation/routes/app_router.gr.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

class ShopBarItemThree extends StatelessWidget {
  final RefreshController controller;
  final StoryModel? story;
  final int index;

  const ShopBarItemThree({
    Key? key,
    required this.story,
    required this.controller,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(StoryList(controller: controller, index: index));
      },
      child: Container(
        margin: EdgeInsets.only(right: 9.r),
        width: 156.r,
        color: Style.transparent,
        child: Stack(
          children: [
            CustomNetworkImage(
              url: story?.url ?? "",
              height: double.infinity,
              width: double.infinity,
              radius: 12.r,
            ),
            Positioned(
                child: Container(
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Style.black.withOpacity(0.2),
                    Style.black.withOpacity(0.2),
                    Style.black.withOpacity(0.2),
                    Style.black.withOpacity(0.5),
                    Style.black.withOpacity(0.7),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            )),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Center(
                child: Text(
                  story?.title ?? "",
                  style: Style.interNoSemi(
                    size: 14,
                    color: Style.white,
                  ),
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
