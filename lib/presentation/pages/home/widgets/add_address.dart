import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/application/home/home_provider.dart';
import 'package:flavourfleet/infrastructure/models/data/address_old_data.dart';
import 'package:flavourfleet/infrastructure/models/data/location.dart';
import 'package:flavourfleet/infrastructure/services/app_constants.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/local_storage.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/buttons/custom_button.dart';
import 'package:flavourfleet/presentation/routes/app_router.gr.dart';
import 'package:flavourfleet/presentation/theme/app_style.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppHelpers.getTranslation(TrKeys.agreeLocation),
          style: Style.interSemi(size: 16.sp),
          textAlign: TextAlign.center,
        ),
        24.verticalSpace,
        Row(
          children: [
            Expanded(
              child: CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.cancel),
                  borderColor: Style.black,
                  background: Style.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                    context.pushRoute(ViewMapRoute(isPop: true));
                  }),
            ),
            24.horizontalSpace,
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                return CustomButton(
                    title: AppHelpers.getTranslation(TrKeys.yes),
                    onPressed: () {
                      Navigator.pop(context);
                      LocalStorage.setAddressSelected(
                        AddressData(
                            title: AppHelpers.getAppAddressName(),
                            location: LocationModel(
                                longitude: (AppHelpers.getInitialLongitude() ??
                                    AppConstants.demoLongitude),
                                latitude: (AppHelpers.getInitialLatitude() ??
                                    AppConstants.demoLatitude))),
                      );
                      ref.read(homeProvider.notifier).setAddress();
                    });
              }),
            ),
          ],
        )
      ],
    );
  }
}
