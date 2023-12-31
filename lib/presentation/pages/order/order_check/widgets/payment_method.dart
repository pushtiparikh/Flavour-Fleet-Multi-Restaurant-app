import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flavourfleet/application/order/order_provider.dart';
import 'package:flavourfleet/application/payment_methods/payment_provider.dart';
import 'package:flavourfleet/application/payment_methods/payment_state.dart';
import 'package:flavourfleet/infrastructure/models/data/payment_data.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/buttons/custom_button.dart';
import 'package:flavourfleet/presentation/components/loading.dart';
import 'package:flavourfleet/presentation/components/title_icon.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';
import '../../../../../../application/payment_methods/payment_notifier.dart';
import '../../../../../infrastructure/services/local_storage.dart';
import '../../../../components/select_item.dart';

class PaymentMethods extends ConsumerStatefulWidget {
  final ValueChanged<PaymentData>? payLater;
  const PaymentMethods({
    this.payLater,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends ConsumerState<PaymentMethods> {
  final bool isLtr = LocalStorage.getLangLtr();
  late PaymentNotifier event;
  late PaymentState state;

  @override
  void didChangeDependencies() {
    event = ref.read(paymentProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    state = ref.watch(paymentProvider);
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            color: Style.bgGrey.withOpacity(0.96),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            )),
        width: double.infinity,
        child: state.isPaymentsLoading
            ? const Loading()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.verticalSpace,
                          Center(
                            child: Container(
                              height: 4.h,
                              width: 48.w,
                              decoration: BoxDecoration(
                                  color: Style.dragElement,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.r))),
                            ),
                          ),
                          14.verticalSpace,
                          TitleAndIcon(
                            title: AppHelpers.getTranslation(
                                TrKeys.paymentMethods),
                          ),
                          24.verticalSpace,
                          ((AppHelpers.getPaymentType() == "admin")
                                  ? (state.payments.isNotEmpty)
                                  : (ref
                                          .watch(orderProvider)
                                          .shopData
                                          ?.shopPayments
                                          ?.isNotEmpty ??
                                      false))
                              ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      (AppHelpers.getPaymentType() == "admin")
                                          ? (state.payments.length)
                                          : (ref
                                                  .watch(orderProvider)
                                                  .shopData
                                                  ?.shopPayments
                                                  ?.length ??
                                              0),
                                  itemBuilder: (context, index) {
                                    return SelectItem(
                                      onTap: () => event.change(index),
                                      isActive: state.currentIndex == index,
                                      title: (AppHelpers.getPaymentType() ==
                                              "admin")
                                          ? (state.payments[index].tag ?? "")
                                          : (ref
                                                  .watch(orderProvider)
                                                  .shopData
                                                  ?.shopPayments?[index]
                                                  ?.payment
                                                  ?.tag ??
                                              ""),
                                    );
                                  })
                              : Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 32.h, left: 24.w, right: 24.w),
                                    child: Text(
                                      AppHelpers.getTranslation(
                                          TrKeys.paymentTypeIsNotAdded),
                                      style: Style.interSemi(
                                        size: 16,
                                        color: Style.textGrey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                        if (widget.payLater != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 32.r),
                      child: CustomButton(
                          title: AppHelpers.getTranslation(TrKeys.pay),
                          onPressed: () {
                            context.popRoute();
                            widget.payLater?.call(PaymentData(
                                id: state
                                    .payments[state.currentIndex].id,
                                tag: state
                                    .payments[state.currentIndex].tag));
                          }),
                    )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
