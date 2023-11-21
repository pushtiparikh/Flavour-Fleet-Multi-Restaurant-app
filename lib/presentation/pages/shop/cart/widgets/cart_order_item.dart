import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flavourfleet/application/order/order_provider.dart';
import 'package:flavourfleet/infrastructure/models/data/addons_data.dart';
import 'package:flavourfleet/infrastructure/models/data/order_active_model.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/presentation/components/custom_network_image.dart';
import 'package:flavourfleet/presentation/pages/shop/cart/widgets/note_product.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';
import '../../../../../infrastructure/models/data/cart_data.dart';

class CartOrderItem extends StatelessWidget {
  final CartDetail? cart;
  final Detail? cartTwo;
  final String? symbol;
  final VoidCallback add;
  final VoidCallback remove;
  final bool isActive;
  final bool isOwn;
  final bool isAddComment;

  const CartOrderItem(
      {Key? key,
      required this.add,
      required this.remove,
      required this.cart,
      this.isActive = true,
      this.cartTwo,
      this.isOwn = true,
      this.symbol,
      this.isAddComment = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    num sumPrice = 0;
    num disSumPrice = 0;
    for (Addons e in (isActive ? cart?.addons ?? [] : cartTwo?.addons ?? [])) {
      sumPrice += (e.price ?? 0);
    }
    disSumPrice = (isActive
                ? (cart?.stock?.totalPrice ?? 0)
                : (cartTwo?.stock?.totalPrice ?? 0)) *
            (cart?.quantity ?? 1) +
        sumPrice +
        (isActive ? (cart?.discount ?? 0) : (cartTwo?.discount ?? 0));
    sumPrice += (isActive
            ? (cart?.stock?.totalPrice ?? 0)
            : (cartTwo?.stock?.totalPrice ?? 0)) *
        (isActive ? (cart?.quantity ?? 1) : (cartTwo?.quantity ?? 1));

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        padding: EdgeInsets.all(16.r),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width - 86.w) * 2 / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isActive
                      ? RichText(
                          text: TextSpan(
                              text: cart?.stock?.product?.translation?.title ??
                                  "",
                              style: Style.interNormal(
                                size: 16,
                                color: Style.black,
                              ),
                              children: [
                              if (cart?.stock?.extras?.isNotEmpty ?? false)
                                TextSpan(
                                  text:
                                      " (${cart?.stock?.extras?.first.value ?? ""})",
                                  style: Style.interNormal(
                                    size: 14,
                                    color: Style.textGrey,
                                  ),
                                )
                            ]))
                      : Row(
                          children: [
                            Expanded(
                              child: Text(
                                cartTwo?.stock?.product?.translation?.title ??
                                    "",
                                style: Style.interNormal(
                                  size: 16,
                                  color: Style.black,
                                ),
                              ),
                            ),
                            if (cartTwo?.stock?.extras?.isNotEmpty ?? false)
                              Text(
                                " (${cartTwo?.stock?.extras?.first.value ?? ""})",
                                style: Style.interNormal(
                                  size: 14,
                                  color: Style.textGrey,
                                ),
                              ),
                          ],
                        ),
                  8.verticalSpace,
                  isActive
                      ? Text(
                          (cart?.stock?.product?.translation?.description ??
                              ""),
                          style: Style.interNormal(
                            size: 12,
                            color: Style.textGrey,
                          ),
                          maxLines: 2,
                        )
                      : Text(
                          cartTwo?.stock?.product?.translation?.description ??
                              "",
                          style: Style.interNormal(
                            size: 12.sp,
                            color: Style.textGrey,
                          ),
                          maxLines: 2,
                        ),
                  8.verticalSpace,
                  for (Addons e in (isActive
                      ? cart?.addons ?? []
                      : cartTwo?.addons ?? []))
                    Text(
                      "${e.stocks?.product?.translation?.title ?? ""} ${AppHelpers.numberFormat(symbol: symbol, isOrder: symbol != null, number: (e.price ?? 0) / (e.quantity ?? 1))} x ${(e.quantity ?? 1)}",
                      style: Style.interNormal(
                        size: 13.sp,
                        color: Style.black,
                      ),
                    ),
                  8.verticalSpace,
                  isActive
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r)),
                                  border: Border.all(color: Style.textGrey)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ((cart?.bonus ?? false) || !isOwn)
                                      ? const SizedBox.shrink()
                                      : GestureDetector(
                                          onTap: remove,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6.h,
                                                horizontal: 10.w),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Style.black,
                                            ),
                                          ),
                                        ),
                                  Padding(
                                    padding: !((cart?.bonus ?? false) || !isOwn)
                                        ? EdgeInsets.zero
                                        : EdgeInsets.symmetric(
                                            vertical: 6.h, horizontal: 16.w),
                                    child: RichText(
                                        text: TextSpan(
                                            text:
                                                "${(cart?.quantity ?? 1) * (cart?.stock?.product?.interval ?? 1)}",
                                            style: Style.interSemi(
                                              size: 14,
                                              color: Style.black,
                                            ),
                                            children: [
                                          TextSpan(
                                            text:
                                                " ${cart?.stock?.product?.unit?.translation?.title}",
                                            style: Style.interSemi(
                                              size: 14,
                                              color: Style.textGrey,
                                            ),
                                          )
                                        ])),
                                  ),
                                  ((cart?.bonus ?? false) || !isOwn)
                                      ? const SizedBox.shrink()
                                      : GestureDetector(
                                          onTap: add,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6.h,
                                                horizontal: 10.w),
                                            child: const Icon(
                                              Icons.add,
                                              color: Style.black,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            16.verticalSpace,
                            !(cart?.bonus ?? false)
                                ? Column(
                                    children: [
                                      Text(
                                        AppHelpers.numberFormat(
                                            isOrder: symbol != null,
                                            symbol: symbol,
                                            number: (cart?.discount ?? 0) != 0
                                                ? disSumPrice
                                                : sumPrice),
                                        style: Style.interSemi(
                                            size: (cart?.discount ?? 0) != 0
                                                ? 12
                                                : 16,
                                            color: Style.black,
                                            decoration:
                                                (cart?.discount ?? 0) != 0
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none),
                                      ),
                                      (cart?.discount ?? 0) != 0
                                          ? Container(
                                              margin: EdgeInsets.only(top: 8.r),
                                              decoration: BoxDecoration(
                                                  color: Style.redBg,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.r)),
                                              padding: EdgeInsets.all(4.r),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      "assets/svgs/discount.svg"),
                                                  4.horizontalSpace,
                                                  Text(
                                                    AppHelpers.numberFormat(
                                                      isOrder: symbol != null,
                                                      symbol: symbol,
                                                      number: sumPrice,
                                                    ),
                                                    style: Style.interNoSemi(
                                                        size: 14,
                                                        color: Style.red),
                                                  )
                                                ],
                                              ),
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ],
                        )
                      : !(cartTwo?.bonus ?? false)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      AppHelpers.numberFormat(
                                          isOrder: symbol != null,
                                          symbol: symbol,
                                          number: cartTwo?.stock?.totalPrice),
                                      style: Style.interSemi(
                                        size: 16,
                                        color: Style.black,
                                      ),
                                    ),
                                    Text(
                                      " X ${(cartTwo?.quantity ?? 1)}",
                                      style: Style.interSemi(
                                        size: 16,
                                        color: Style.black,
                                      ),
                                    ),
                                    Text(
                                      " (${(cartTwo?.quantity ?? 1) * (cartTwo?.stock?.product?.interval ?? 1)} ${cartTwo?.stock?.product?.unit?.translation?.title})",
                                      style: Style.interNormal(
                                        size: 12,
                                        color: Style.textGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                8.verticalSpace,
                                Text(
                                  AppHelpers.numberFormat(
                                      isOrder: symbol != null,
                                      symbol: symbol,
                                      number: sumPrice),
                                  style: Style.interSemi(
                                    size: 16,
                                    color: Style.black,
                                  ),
                                ),
                                8.horizontalSpace
                              ],
                            )
                          : Text(
                              AppHelpers.numberFormat(
                                  isOrder: symbol != null,
                                  symbol: symbol,
                                  number: cartTwo?.originPrice ?? 0),
                              style: Style.interSemi(
                                size: 16,
                                color: Style.black,
                              ),
                            ),
                ],
              ),
            ),
            4.horizontalSpace,
            Expanded(
              child: Stack(
                children: [
                  CustomNetworkImage(
                      url: isActive
                          ? cart?.stock?.product?.img ?? ""
                          : cartTwo?.stock?.product?.img ?? "",
                      height: 120.h,
                      width: double.infinity,
                      radius: 10.r),
                  (cart?.bonus ?? false) || (cartTwo?.bonus ?? false)
                      ? Positioned(
                          bottom: 4.r,
                          right: 4.r,
                          child: Container(
                            width: 22.w,
                            height: 22.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Style.blueBonus),
                            child: Icon(
                              FlutterRemix.gift_2_fill,
                              size: 16.r,
                              color: Style.white,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  if (isAddComment)
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Consumer(
                          builder: (context, provider, child) {
                            return IconButton(
                                onPressed: () {
                                  AppHelpers.showAlertDialog(
                                      context: context,
                                      child: NoteProduct(
                                        isSave: cartTwo == null,
                                        comment: cartTwo?.note,
                                        onTap: (s) {
                                          provider
                                              .read(orderProvider.notifier)
                                              .setNotes(
                                                  stockId: cart?.stock?.id ?? 0,
                                                  note: s);
                                        },
                                      ));
                                },
                                icon: Icon(
                                  FlutterRemix.edit_box_line,
                                  size: 24.r,
                                  color: Style.red,
                                ));
                          },
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
