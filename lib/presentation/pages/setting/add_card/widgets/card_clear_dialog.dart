import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/buttons/custom_button.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

class CardClearDialog extends StatelessWidget {
  final String cardName;
  final VoidCallback cancel;
  final VoidCallback clear;

  const CardClearDialog(
      {Key? key,
      required this.cancel,
      required this.clear,
      required this.cardName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.sizeOf(context).width - 60.w),
      decoration: BoxDecoration(
        color: Style.white.withOpacity(0.96),
        boxShadow: [
          BoxShadow(
            color: Style.white.withOpacity(0.65),
            spreadRadius: 0,
            blurRadius: 60,
            offset: const Offset(0, 20), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppHelpers.getTranslation(TrKeys.clearCard1),
            style: Style.interNormal(
              size: 16,
              color: Style.black,
            ),
          ),
          Text(
            cardName,
            style: Style.interSemi(
              size: 16,
              color: Style.black,
            ),
          ),
          Text(
            AppHelpers.getTranslation(TrKeys.clearCard2),
            style: Style.interNormal(
              size: 16,
              color: Style.black,
            ),
          ),
          50.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                title: AppHelpers.getTranslation(TrKeys.cancel),
                onPressed: () {
                  // TODO cancel
                  cancel();
                  Navigator.pop(context);
                },
                weight: (MediaQuery.sizeOf(context).width - 120.w) / 2,
                background: Style.black,
                textColor: Style.white,
              ),
              CustomButton(
                title: AppHelpers.getTranslation(TrKeys.clear),
                onPressed: () {
                  //TODO clear
                  clear();
                  Navigator.pop(context);
                },
                weight: (MediaQuery.sizeOf(context).width - 120.w) / 2,
                background: Style.red,
                textColor: Style.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
