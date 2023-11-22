import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flavourfleet/domain/iterface/parcel.dart';
import 'package:flavourfleet/infrastructure/models/models.dart';
import 'package:flavourfleet/infrastructure/services/app_connectivity.dart';
import 'package:flavourfleet/infrastructure/services/app_constants.dart';
import 'package:flavourfleet/infrastructure/services/app_helpers.dart';
import 'package:flavourfleet/infrastructure/services/marker_image_cropper.dart';
import 'package:flavourfleet/presentation/routes/app_router.gr.dart';

import '../../domain/iterface/draw.dart';
import 'parcel_state.dart';

class ParcelNotifier extends StateNotifier<ParcelState> {
  final ParcelRepositoryFacade _parcelRepository;
  final DrawRepositoryFacade _drawRouting;

  ParcelNotifier(this._parcelRepository, this._drawRouting)
      : super(const ParcelState());

  Future<void> addReview(
      BuildContext context, String comment, double rating) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isButtonLoading: true);
      final response = await _parcelRepository.addReview(
          state.parcel?.id ?? 0,
          rating: rating,
          comment: comment);
      response.when(
        success: (data) async {
          state = state.copyWith(isButtonLoading: false);
          context.popRoute(context);
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isButtonLoading: false);
          if (mounted) {
            AppHelpers.showCheckTopSnackBar(
              context,
              activeFailure,
            );
          }
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  changeExpand() {
    state = state.copyWith(expand: !state.expand);
  }

  changeAnonymous() {
    state = state.copyWith(anonymous: !state.anonymous);
  }

  Future<void> fetchTypes(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _parcelRepository.getTypes();
      response.when(
        success: (data) {
          state = state.copyWith(isLoading: false, types: data.data ?? []);
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(status.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> getCalculate(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true, error: false);
      final response = await _parcelRepository.getCalculate(
          typeId: state.types[state.selectType]?.id ?? 0,
          from: state.locationFrom ?? LocationModel(),
          to: state.locationTo ?? LocationModel());
      response.when(
        success: (data) {
          state = state.copyWith(isLoading: false, calculate: data);
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isLoading: false, error: true);
          AppHelpers.showCheckTopSnackBar(
            context,
            activeFailure,
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> orderParcel({
    required BuildContext context,
    required String note,
    required String usernameTo,
    required String usernameFrom,
    required String phoneTo,
    required String phoneFrom,
    required String houseFrom,
    required String houseTo,
    required String floorTo,
    required String floorFrom,
    required String comment,
    required String value,
    required String instruction,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _parcelRepository.orderParcel(
          typeId: state.types[state.selectType]?.id ?? 0,
          from: state.locationFrom ?? LocationModel(),
          to: state.locationTo ?? LocationModel(),
          fromTitle: state.addressFrom ?? "",
          toTitle: state.addressTo ?? "",
          time:
              "${(state.time ?? TimeOfDay.now()).hour} : ${(state.time ?? TimeOfDay.now()).minute}",
          note: note,
          phoneFrom: phoneFrom,
          phoneTo: phoneTo,
          usernameTo: usernameTo,
          usernameFrom: usernameFrom,
          notify: state.anonymous,
          floorTo: floorTo,
          floorFrom: floorFrom,
          houseFrom: houseFrom,
          houseTo: houseTo,
          comment: comment,
          value: value,
          instruction: instruction);
      response.when(
        success: (data) {
          state = state.copyWith(isLoading: false);
          context.replaceRoute(const ParcelListRoute());
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(status.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  void selectType({required int index, required BuildContext context}) {
    state = state.copyWith(selectType: index);
    if (state.types.isNotEmpty &&
        state.addressFrom != null &&
        state.addressTo != null) {
      getCalculate(context);
    }
  }

  void setToAddress(
      {required String? title,
      required LocationModel? location,
      required BuildContext context}) {
    state = state.copyWith(addressTo: title, locationTo: location);
    if (state.types.isNotEmpty &&
        state.addressFrom != null &&
        state.addressTo != null) {
      getCalculate(context);
    }
  }

  void setFromAddress(
      {required String? title,
      required LocationModel? location,
      required BuildContext context}) {
    state = state.copyWith(addressFrom: title, locationFrom: location);
    if (state.types.isNotEmpty &&
        state.addressFrom != null &&
        state.addressTo != null) {
      getCalculate(context);
    }
  }

  void switchAddress({required BuildContext context}) {
    state = state.copyWith(
        addressFrom: state.addressTo,
        locationFrom: state.locationTo,
        addressTo: state.addressFrom,
        locationTo: state.locationFrom);
    if (state.types.isNotEmpty &&
        state.addressFrom != null &&
        state.addressTo != null) {
      getCalculate(context);
    }
  }

  void setTime({required TimeOfDay time}) {
    state = state.copyWith(time: time);
  }

  Future<void> showParcel(
      BuildContext context, num orderId, bool isRefresh) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (!isRefresh) {
        state = state.copyWith(isLoading: true);
      }

      final response = await _parcelRepository.getSingleParcel(orderId);
      response.when(
        success: (data) async {
          final ImageCropperForMarker image = ImageCropperForMarker();
          if (!isRefresh) {
            state = state.copyWith(
                parcel: data, isLoading: false, isMapLoading: true);
            Map<MarkerId, Marker> list = {
              const MarkerId("Shop"): Marker(
                  markerId: const MarkerId("Shop"),
                  position: LatLng(
                    data.addressFrom?.latitude ?? AppConstants.demoLatitude,
                    data.addressFrom?.longitude ?? AppConstants.demoLongitude,
                  ),
                  icon: await image.resizeAndCircle(data.user?.img ?? "", 120)),
              const MarkerId("User"): Marker(
                  markerId: const MarkerId("User"),
                  position: LatLng(
                    data.addressTo?.latitude ?? AppConstants.demoLatitude,
                    data.addressTo?.longitude ?? AppConstants.demoLongitude,
                  ),
                  icon: await image.resizeAndCircle("", 120)),
            };
            state = state.copyWith(markers: list, isMapLoading: false);

            // ignore: use_build_context_synchronously
            getRoutingAll(
                context: context,
                end: LatLng(
                  data.addressTo?.latitude ?? AppConstants.demoLatitude,
                  data.addressTo?.longitude ?? AppConstants.demoLongitude,
                ),
                start: LatLng(
                  data.addressFrom?.latitude ?? AppConstants.demoLatitude,
                  data.addressFrom?.longitude ?? AppConstants.demoLongitude,
                ));
          } else {
            state = state.copyWith(parcel: data);
            Map<MarkerId, Marker> list = {
              const MarkerId("Shop"): Marker(
                  markerId: const MarkerId("Shop"),
                  position: LatLng(
                    data.addressFrom?.latitude ?? AppConstants.demoLatitude,
                    data.addressFrom?.longitude ?? AppConstants.demoLongitude,
                  ),
                  icon: await image.resizeAndCircle(data.user?.img ?? "", 120)),
              const MarkerId("User"): Marker(
                  markerId: const MarkerId("User"),
                  position: LatLng(
                    data.addressTo?.latitude ?? AppConstants.demoLatitude,
                    data.addressTo?.longitude ?? AppConstants.demoLongitude,
                  ),
                  icon: await image.resizeAndCircle("", 120)),
            };

            state = state.copyWith(markers: list);
          }
        },
        failure: (activeFailure, status) {
          if (!isRefresh) {
            state = state.copyWith(isLoading: false);
          }
          if (mounted) {
            AppHelpers.showCheckTopSnackBar(
              context,
              activeFailure,
            );
          }
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> getRoutingAll({
    required BuildContext context,
    required LatLng start,
    required LatLng end,
  }) async {
    if (await AppConnectivity.connectivity()) {
      state = state.copyWith(polylineCoordinates: []);
      final response = await _drawRouting.getRouting(start: start, end: end);
      response.when(
        success: (data) {
          List<LatLng> list = [];
          List ls = data.features[0].geometry.coordinates;
          for (int i = 0; i < ls.length; i++) {
            list.add(LatLng(ls[i][1], ls[i][0]));
          }
          state = state.copyWith(
            polylineCoordinates: list,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(polylineCoordinates: []);
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }
}
