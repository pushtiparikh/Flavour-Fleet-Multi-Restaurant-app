// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flavourfleet/application/notification/notification_provider.dart';
import 'package:flavourfleet/infrastructure/models/response/notification_response.dart';
import 'package:flavourfleet/infrastructure/services/app_constants.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/local_storage.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/app_bars/common_app_bar.dart';
import 'package:flavourfleet/presentation/components/buttons/custom_button.dart';
import 'package:flavourfleet/presentation/components/buttons/pop_button.dart';
import 'package:flavourfleet/presentation/components/custom_network_image.dart';
import 'package:flavourfleet/presentation/components/loading.dart';
import 'package:flavourfleet/presentation/routes/app_router.gr.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_style.dart';

class NotificationListPage extends ConsumerStatefulWidget {
  const NotificationListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationListPage> createState() =>
      _NotificationListPageState();
}

class _NotificationListPageState extends ConsumerState<NotificationListPage> {
  final bool isLtr = LocalStorage.getLangLtr();
  late RefreshController refreshController;

  @override
  void initState() {
    refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider.notifier).fetchAllNotifications(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationProvider);
    final event = ref.read(notificationProvider.notifier);
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Style.bgGrey,
        body: state.isAllNotificationsLoading
            ? const Loading()
            : Column(
                children: [
                  CommonAppBar(
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.notifications),
                      style: Style.interNoSemi(
                        size: 18,
                        color: Style.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SmartRefresher(
                      controller: refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () {
                        event.fetchNotificationsPaginate(
                            refreshController: refreshController,
                            isRefresh: true);
                      },
                      onLoading: () {
                        event.fetchNotificationsPaginate(
                          refreshController: refreshController,
                        );
                      },
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              top: 24.h,
                              right: 16.w,
                              left: 16.w,
                              bottom:
                                  MediaQuery.of(context).padding.bottom + 72.h),
                          itemCount: state.notifications.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                if (state.notifications[index].readAt == null) {
                                  event.readOne(
                                      index: index,
                                      context,
                                      id: state.notifications[index].id);
                                }
                                if (state.notifications[index].orderData !=
                                    null) {
                                  context.pushRoute(OrderProgressRoute(
                                      orderId: state
                                          .notifications[index].orderData?.id));
                                } else if (state
                                        .notifications[index].blogData !=
                                    null) {
                                  await launch(
                                    "${AppConstants.webUrl}/blog/${state.notifications[index].blogData?.uuid}",
                                    forceSafariVC: true,
                                    forceWebView: true,
                                    enableJavaScript: true,
                                  );
                                } else if (state.notifications[index].type ==
                                    "reservation") {
                                  await launch(
                                    "${AppConstants.webUrl}/reservations",
                                    forceSafariVC: true,
                                    forceWebView: true,
                                    enableJavaScript: true,
                                  );
                                } else {
                                  AppHelpers.showAlertDialog(
                                      context: context,
                                      child: Text(
                                          '${state.notifications[index].body ?? state.notifications[index].title}'));
                                }
                              },
                              child: Column(
                                children: [
                                  notificationItem(state.notifications[index]),
                                  const Divider()
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              const PopButton(),
              10.horizontalSpace,
              Expanded(
                  child: CustomButton(
                background: Style.black,
                textColor: Style.white,
                title: AppHelpers.getTranslation(TrKeys.readAll),
                onPressed: () async {
                  event.readAll(context);
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget notificationItem(NotificationModel notification) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.r),
      child: Row(
        children: [
          CustomNetworkImage(
            profile: true,
            radius: 22,
            url: notification.client?.img ?? notification.blogData?.img ?? "",
            height: 44,
            width: 44,
          ),
          12.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (notification.client != null)
                Row(
                  children: [
                    Text(
                      '${notification.client?.firstname ?? ''} ${notification.client?.lastname?.substring(0, 1) ?? ''}.',
                      style: Style.interSemi(size: 16, color: Style.black),
                    ),
                    15.horizontalSpace,
                    Container(
                      height: 8.r,
                      width: 8.r,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: notification.readAt == null
                              ? Style.brandGreen
                              : Style.transparent),
                    )
                  ],
                ),
              2.verticalSpace,
              Row(
                children: [
                  SizedBox(
                    width: notification.client != null
                        ? MediaQuery.sizeOf(context).width / 2
                        : null,
                    child: Text(
                      '${notification.body ?? notification.title}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Style.interRegular(size: 14, color: Style.black),
                    ),
                  ),
                  if (notification.client == null)
                    Container(
                      margin: EdgeInsets.only(left: 8.r),
                      height: 8.r,
                      width: 8.r,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: notification.readAt == null
                              ? Style.brandGreen
                              : Style.transparent),
                    )
                ],
              ),
              4.verticalSpace,
              Text(
                Jiffy(notification.createdAt ?? DateTime.now()).fromNow(),
                style: Style.interRegular(size: 12, color: Style.textGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
