import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/local_storage.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/buttons/custom_button.dart';
import 'package:flavourfleet/presentation/routes/app_router.gr.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

class DoorToDoor extends StatelessWidget {
  const DoorToDoor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(30.r),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Style.doorColor, borderRadius: BorderRadius.circular(24.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppHelpers.getTranslation(TrKeys.doorToDoor),
            style: Style.interSemi(size: 42),
          ),
          10.verticalSpace,
          Text(
            AppHelpers.getTranslation(TrKeys.yourPersonalDoor),
            style: Style.interRegular(size: 16),
          ),
          20.verticalSpace,
          Image.asset("assets/images/door.png"),
          10.verticalSpace,
          CustomButton(
            title: AppHelpers.getTranslation(TrKeys.learnMore),
            onPressed: () {
              if (LocalStorage.getToken().isEmpty) {
                context.pushRoute(const LoginRoute());
                return;
              }
              context.pushRoute(const ParcelRoute());
              return;

            },
            background: Style.transparent,
            borderColor: Style.black,
          )
        ],
      ),
    );
  }
}
