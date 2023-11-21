import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/infrastructure/models/data/address_new_data.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

class SelectAddressItem extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback update;
  final bool isActive;
  final AddressNewModel? address;

  const SelectAddressItem({
    Key? key,
    required this.onTap,
    required this.isActive,
    required this.address,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Style.white,
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: Padding(
            padding: EdgeInsets.all(18.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 18.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                      color: isActive ? Style.brandGreen : Style.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: isActive ? Style.black : Style.textGrey,
                          width: isActive ? 4.r : 2.r)),
                ),
                16.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 150.r,
                      child: Text(
                        address?.title ?? address?.address?.address ?? "",
                        style: Style.interNormal(
                          size: 16,
                          color: Style.black,
                        ),
                      ),
                    ),
                    if(address?.title != null)
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 150.r,
                      child: Text(
                        address?.address?.address ?? "",
                        style: Style.interNormal(
                          size: 12,
                          color: Style.textGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      update.call();
                    },
                    icon: const Icon(FlutterRemix.equalizer_line)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}