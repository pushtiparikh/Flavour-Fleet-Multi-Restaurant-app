
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/infrastructure/models/models.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/presentation/components/custom_network_image.dart';
import 'package:flavourfleet/presentation/pages/home/widgets/banner_screen.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

class BannerItemThree extends StatelessWidget {
  final BannerData banner;

  const BannerItemThree({
    Key? key,
    required this.banner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppHelpers.showCustomModalBottomSheet(
            context: context,
            modal: BannerScreen(
              bannerId: banner.id ?? 0,
              image: banner.img ?? "",
              desc: banner.translation?.description ?? "",
              list: banner.shops ?? [],
            ),
            isDarkMode: false);
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.r),
          width: MediaQuery.of(context).size.width - 46,
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
          ),
          child: CustomNetworkImage(
            bgColor: Style.white,
            url: banner.img ?? "",
            width: double.infinity,
            radius: 15.r, height: double.infinity,
          )),
    );
  }
}
