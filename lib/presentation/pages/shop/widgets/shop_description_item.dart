import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';

class ShopDescriptionItem extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;
  const ShopDescriptionItem({Key? key, required this.title, required this.description, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 98.h,
      decoration: BoxDecoration(
          color: Style.bgGrey,
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      padding: EdgeInsets.all(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          4.verticalSpace,
          Text(
            title,
            style: Style.interRegular(
              size: 12,
              color: Style.black,
            ),
          ),
          SizedBox(
            width: (MediaQuery.sizeOf(context).width-132.h)/3,
            child: Text(
              description,
              style: Style.interSemi(
                size: 12,
                color: Style.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

          ),
        ],
      ),
    );
  }
}
