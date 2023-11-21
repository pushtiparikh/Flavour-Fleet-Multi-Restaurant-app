// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flavourfleet/application/app_widget/app_provider.dart';
import 'package:flavourfleet/application/home/home_provider.dart';
import 'package:flavourfleet/application/map/view_map_state.dart';
import 'package:flavourfleet/application/profile/profile_provider.dart';
import 'package:flavourfleet/domain/di/dependency_manager.dart';
import 'package:flavourfleet/infrastructure/models/data/address_information.dart';
import 'package:flavourfleet/infrastructure/models/data/address_new_data.dart';
import 'package:flavourfleet/infrastructure/models/data/address_old_data.dart';
import 'package:flavourfleet/infrastructure/models/data/location.dart';
import 'package:flavourfleet/infrastructure/services/app_constants.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/local_storage.dart';
import 'package:flavourfleet/infrastructure/services/tpying_delay.dart';
import 'package:flavourfleet/infrastructure/services/tr_keys.dart';
import 'package:flavourfleet/presentation/components/buttons/custom_button.dart';
import 'package:flavourfleet/presentation/components/buttons/pop_button.dart';
import 'package:flavourfleet/presentation/components/keyboard_dismisser.dart';
import 'package:flavourfleet/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:flavourfleet/presentation/components/text_fields/search_text_field.dart';
import 'package:flavourfleet/presentation/routes/app_router.gr.dart';
import 'package:flavourfleet/presentation/theme/theme.dart';
import '../../../../application/map/view_map_notifier.dart';
import '../../../../application/map/view_map_provider.dart';

class ViewMapPage extends ConsumerStatefulWidget {
  final bool isShopLocation;
  final bool isPop;
  final int? shopId;
  final int? indexAddress;
  final AddressNewModel? address;

  const ViewMapPage({
    Key? key,
    this.isPop = true,
    this.isShopLocation = false,
    this.shopId,
    this.indexAddress,
    this.address,
  }) : super(key: key);

  @override
  ConsumerState<ViewMapPage> createState() => _ViewMapPageState();
}

class _ViewMapPageState extends ConsumerState<ViewMapPage> {
  late ViewMapNotifier event;
  late TextEditingController controller;
  late TextEditingController office;
  late TextEditingController house;
  late TextEditingController floor;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  GoogleMapController? googleMapController;
  CameraPosition? cameraPosition;
  dynamic check;
  late LatLng latLng;
  final Delayed delayed = Delayed(milliseconds: 700);
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    event = ref.read(viewMapProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    office.dispose();
    house.dispose();
    floor.dispose();
    super.dispose();
  }

  checkPermission() async {
    check = await _geolocatorPlatform.checkPermission();
  }

  Future<void> getMyLocation() async {
    if (check == LocationPermission.denied ||
        check == LocationPermission.deniedForever) {
      check = await Geolocator.requestPermission();
      if (check != LocationPermission.denied &&
          check != LocationPermission.deniedForever) {
        var loc = await Geolocator.getCurrentPosition();
        latLng = LatLng(loc.latitude, loc.longitude);
        googleMapController!
            .animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
      }
    } else {
      if (check != LocationPermission.deniedForever) {
        var loc = await Geolocator.getCurrentPosition();
        latLng = LatLng(loc.latitude, loc.longitude);
        googleMapController!
            .animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
      }
    }
  }

  @override
  void initState() {
    controller = TextEditingController(text: widget.address?.address?.address);
    office = TextEditingController(text: widget.address?.title);
    house = TextEditingController();
    floor = TextEditingController();
    latLng = LatLng(
      widget.address?.location?.first ??
          LocalStorage.getAddressSelected()?.location?.latitude ??
          (AppHelpers.getInitialLatitude() ?? AppConstants.demoLatitude),
      widget.address?.location?.last ??
          LocalStorage.getAddressSelected()?.location?.longitude ??
          (AppHelpers.getInitialLongitude() ?? AppConstants.demoLongitude),
    );
    checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(viewMapProvider);
    final bool isLtr = LocalStorage.getLangLtr();
    final bool isDarkMode = ref.watch(appProvider).isDarkMode;
    return KeyboardDismisser(
      child: Directionality(
        textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          backgroundColor: isDarkMode ? Style.mainBackDark : Style.mainBack,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: state.isScrolling
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.height - 420.r,
                  child: GoogleMap(
                    onCameraMoveStarted: () {
                      ref.read(viewMapProvider.notifier).scrolling(true);
                    },
                    myLocationButtonEnabled: false,
                    initialCameraPosition: CameraPosition(
                      bearing: 0,
                      target: latLng,
                      tilt: 0,
                      zoom: 17,
                    ),
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    onTap: (position) {
                      event.updateActive();
                      delayed.run(() async {
                        try {
                          final List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                            cameraPosition?.target.latitude ?? latLng.latitude,
                            cameraPosition?.target.longitude ??
                                latLng.longitude,
                          );

                          if (placemarks.isNotEmpty) {
                            final Placemark pos = placemarks[0];
                            final List<String> addressData = [];
                            addressData.add(pos.locality!);
                            if (pos.subLocality != null &&
                                pos.subLocality!.isNotEmpty) {
                              addressData.add(pos.subLocality!);
                            }
                            if (pos.thoroughfare != null &&
                                pos.thoroughfare!.isNotEmpty) {
                              addressData.add(pos.thoroughfare!);
                            }
                            addressData.add(pos.name!);
                            final String placeName = addressData.join(', ');
                            controller.text = placeName;
                          }
                        } catch (e) {
                          controller.text = '';
                        }

                        event
                          ..checkDriverZone(
                              context: context,
                              location: LatLng(
                                cameraPosition?.target.latitude ??
                                    latLng.latitude,
                                cameraPosition?.target.longitude ??
                                    latLng.longitude,
                              ),
                              shopId: widget.shopId)
                          ..changePlace(
                            AddressNewModel(
                              address:
                                  AddressInformation(address: controller.text),
                              location: [
                                cameraPosition?.target.latitude ??
                                    latLng.latitude,
                                cameraPosition?.target.longitude ??
                                    latLng.longitude
                              ],
                            ),
                          );
                      });
                      googleMapController!.animateCamera(
                          CameraUpdate.newLatLngZoom(position, 15));
                    },
                    onCameraIdle: () {
                      event.updateActive();
                      delayed.run(() async {
                        try {
                          final List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                            cameraPosition?.target.latitude ?? latLng.latitude,
                            cameraPosition?.target.longitude ??
                                latLng.longitude,
                          );

                          if (placemarks.isNotEmpty) {
                            final Placemark pos = placemarks[0];
                            final List<String> addressData = [];
                            addressData.add(pos.locality!);
                            if (pos.subLocality != null &&
                                pos.subLocality!.isNotEmpty) {
                              addressData.add(pos.subLocality!);
                            }
                            if (pos.thoroughfare != null &&
                                pos.thoroughfare!.isNotEmpty) {
                              addressData.add(pos.thoroughfare!);
                            }
                            addressData.add(pos.name!);
                            final String placeName = addressData.join(', ');
                            controller.text = placeName;
                          }
                        } catch (e) {
                          controller.text = '';
                        }

                        if (!widget.isShopLocation) {
                          event
                            ..checkDriverZone(
                                context: context,
                                location: LatLng(
                                  cameraPosition?.target.latitude ??
                                      latLng.latitude,
                                  cameraPosition?.target.longitude ??
                                      latLng.longitude,
                                ),
                                shopId: widget.shopId)
                            ..changePlace(
                              AddressNewModel(
                                address: AddressInformation(
                                    address: controller.text),
                                location: [
                                  cameraPosition?.target.latitude ??
                                      latLng.latitude,
                                  cameraPosition?.target.longitude ??
                                      latLng.longitude
                                ],
                              ),
                            );
                        } else {
                          event.changePlace(
                            AddressNewModel(
                              address:
                                  AddressInformation(address: controller.text),
                              location: [
                                cameraPosition?.target.latitude ??
                                    latLng.latitude,
                                cameraPosition?.target.longitude ??
                                    latLng.longitude
                              ],
                            ),
                          );
                        }
                        ref.read(viewMapProvider.notifier).scrolling(false);
                      });
                    },
                    onCameraMove: (position) {
                      cameraPosition = position;
                    },
                    onMapCreated: (controller) {
                      googleMapController = controller;
                    },
                  ),
                ),
                AnimatedPositioned(
                  bottom: MediaQuery.of(context).padding.bottom +
                      (MediaQuery.sizeOf(context).height / 2) +
                      (state.isScrolling ? 0 : 210.r),
                  left: MediaQuery.sizeOf(context).width / 2 - 23.w,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    "assets/images/marker.png",
                    width: 46.w,
                    height: 46.h,
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  bottom: 440.r,
                  right: state.isScrolling ? -100 : 16.w,
                  child: InkWell(
                    onTap: () async {
                      await getMyLocation();
                    },
                    child: Container(
                      width: 50.r,
                      height: 50.r,
                      decoration: BoxDecoration(
                          color: Style.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          boxShadow: [
                            BoxShadow(
                                color: Style.shimmerBase,
                                blurRadius: 2,
                                offset: const Offset(0, 2))
                          ]),
                      child: const Center(
                          child: Icon(FlutterRemix.navigation_line)),
                    ),
                  ),
                ),
                if (widget.address != null &&
                    !(widget.address?.active ?? false))
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    top: 32.r,
                    right: state.isScrolling ? -100 : 16.w,
                    child: InkWell(
                      onTap: () async {
                        ref.read(profileProvider.notifier).deleteAddress(
                            index: widget.indexAddress ?? 0,
                            id: widget.address?.id);
                        context.popRoute();
                      },
                      child: Container(
                        width: 48.r,
                        height: 48.r,
                        decoration: BoxDecoration(
                            color: Style.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.r)),
                            boxShadow: [
                              BoxShadow(
                                  color: Style.shimmerBase,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2))
                            ]),
                        child: const Center(
                            child: Icon(
                          FlutterRemix.delete_bin_fill,
                          color: Style.white,
                        )),
                      ),
                    ),
                  ),
                _bottomSheet(context, state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomSheet(BuildContext context, ViewMapState state) {
    return AnimatedPositioned(
      bottom: state.isScrolling ? -400.r : 0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        height: 420.r,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                topLeft: Radius.circular(16.r))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            8.verticalSpace,
            Container(
              width: 49.w,
              height: 3.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: Style.dragElement,
              ),
            ),
            16.verticalSpace,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppHelpers.getTranslation(TrKeys.enterADeliveryAddress),
                style: Style.interNoSemi(size: 18),
              ),
            ),
            24.verticalSpace,
            SearchTextField(
              isRead: true,
              isBorder: true,
              textEditingController: controller,
              onTap: () async {
                final placeId = await context.pushRoute(const MapSearchRoute());
                if (placeId != null) {
                  final res = await googlePlace.details.get(placeId.toString());
                  try {
                    final List<Placemark> placemarks =
                        await placemarkFromCoordinates(
                      res?.result?.geometry?.location?.lat ?? latLng.latitude,
                      res?.result?.geometry?.location?.lng ?? latLng.longitude,
                    );

                    if (placemarks.isNotEmpty) {
                      final Placemark pos = placemarks[0];
                      final List<String> addressData = [];
                      addressData.add(pos.locality!);
                      if (pos.subLocality != null &&
                          pos.subLocality!.isNotEmpty) {
                        addressData.add(pos.subLocality!);
                      }
                      if (pos.thoroughfare != null &&
                          pos.thoroughfare!.isNotEmpty) {
                        addressData.add(pos.thoroughfare!);
                      }
                      addressData.add(pos.name!);
                      final String placeName = addressData.join(', ');
                      controller.text = placeName;
                    }
                  } catch (e) {
                    controller.text = '';
                  }

                  googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(
                      LatLng(
                          res?.result?.geometry?.location?.lat ??
                              latLng.latitude,
                          res?.result?.geometry?.location?.lng ??
                              latLng.longitude),
                      15));
                  event.changePlace(
                    AddressNewModel(
                      address: AddressInformation(address: controller.text),
                      location: [
                        cameraPosition?.target.latitude ?? latLng.latitude,
                        cameraPosition?.target.longitude ?? latLng.longitude
                      ],
                    ),
                  );
                }
              },
            ),
            24.verticalSpace,
            Form(
              key: fromKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedBorderTextField(
                    textController: office,
                    label:
                        AppHelpers.getTranslation(TrKeys.title).toUpperCase(),
                    validation: (s) {
                      if (s?.isEmpty ?? true) {
                        return AppHelpers.getTranslation(TrKeys.canNotBeEmpty);
                      } else {
                        return null;
                      }
                    },
                  ),
                  24.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedBorderTextField(
                          textController: house,
                          label: AppHelpers.getTranslation(TrKeys.house)
                              .toUpperCase(),
                        ),
                      ),
                      24.horizontalSpace,
                      Expanded(
                        child: OutlinedBorderTextField(
                          textController: floor,
                          label: AppHelpers.getTranslation(TrKeys.floor)
                              .toUpperCase(),
                        ),
                      ),
                    ],
                  ),
                  32.verticalSpace,
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if(widget.isPop)
                  const PopButton(),
                  24.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      isLoading:
                          !widget.isShopLocation ? state.isLoading : false,
                      background: !widget.isShopLocation
                          ? (state.isActive ? Style.brandGreen : Style.bgGrey)
                          : Style.brandGreen,
                      textColor: !widget.isShopLocation
                          ? (state.isActive ? Style.black : Style.textGrey)
                          : Style.black,
                      title: !widget.isShopLocation
                          ? (state.isActive
                              ? AppHelpers.getTranslation(TrKeys.apply)
                              : AppHelpers.getTranslation(TrKeys.noDriverZone))
                          : AppHelpers.getTranslation(TrKeys.apply),
                      onPressed: () {
                        if (widget.isShopLocation) {
                          Navigator.pop(context, state.place);
                        } else {
                          if (state.isActive) {
                            ref.read(homeProvider.notifier)
                              ..fetchBannerPage(context, RefreshController(),
                                  isRefresh: true)
                              ..fetchRestaurantPage(
                                  context, RefreshController(),
                                  isRefresh: true)
                              ..fetchShopPageRecommend(
                                  context, RefreshController(),
                                  isRefresh: true)
                              ..fetchShopPage(context, RefreshController(),
                                  isRefresh: true)
                              ..fetchStorePage(context, RefreshController(),
                                  isRefresh: true)
                              ..fetchRestaurantPageNew(
                                  context, RefreshController(),
                                  isRefresh: true)
                              ..fetchCategoriesPage(
                                  context, RefreshController(),
                                  isRefresh: true)
                              ..setAddress();
                            LocalStorage.setAddressSelected(AddressData(
                                title: office.text,
                                address: state.place?.address?.address ?? "",
                                location: LocationModel(
                                    latitude: state.place?.location?.first,
                                    longitude: state.place?.location?.last)));
                            AddressInformation data = AddressInformation(
                                address: controller.text,
                                house: house.text,
                                floor: floor.text);
                            LocalStorage.setAddressInformation(data);
                            if (LocalStorage.getToken().isEmpty) {
                              Navigator.pop(context);
                              return;
                            }
                            if (widget.address == null) {
                              event.saveLocation(context, onSuccess: () {
                                ref
                                    .read(profileProvider.notifier)
                                    .fetchUser(context);
                                ref.read(homeProvider.notifier).setAddress();
                                Navigator.pop(context);
                              });
                            } else {
                              event.updateLocation(context, widget.address?.id,
                                  onSuccess: () {
                                ref
                                    .read(profileProvider.notifier)
                                    .fetchUser(context);
                                ref.read(homeProvider.notifier).setAddress();
                                Navigator.pop(context);
                              });
                            }
                          } else {
                            AppHelpers.showCheckTopSnackBarInfo(
                              context,
                              AppHelpers.getTranslation(TrKeys.noDriverZone),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
