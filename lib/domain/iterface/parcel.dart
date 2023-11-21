import 'package:flavourfleet/domain/handlers/handlers.dart';
import 'package:flavourfleet/infrastructure/models/data/location.dart';
import 'package:flavourfleet/infrastructure/models/data/parcel_order.dart';
import 'package:flavourfleet/infrastructure/models/response/parcel_calculate_response.dart';
import 'package:flavourfleet/infrastructure/models/response/parcel_paginate_response.dart';
import 'package:flavourfleet/infrastructure/models/response/parcel_response.dart';

abstract class ParcelRepositoryFacade {
  Future<ApiResult<ParcelTypeResponse>> getTypes();

  Future<ApiResult<ParcelCalculateResponse>> getCalculate(
      {required int typeId,
      required LocationModel from,
      required LocationModel to});

  Future<ApiResult> orderParcel(
      {required int typeId,
        required LocationModel from,
        required String fromTitle,
        required LocationModel to,
        required String toTitle,
        required String time,
        required String note,
        required String phoneFrom,
        required String phoneTo,
        required String usernameTo,
        required String usernameFrom,
        required String floorTo,
        required String floorFrom,
        required String houseFrom,
        required String houseTo,
        required String comment,
        required String value,
        required String instruction,
        required bool notify,
      });


  Future<ApiResult<ParcelPaginateResponse>> getActiveParcel(int page);

  Future<ApiResult<ParcelPaginateResponse>> getHistoryParcel(int page);

  Future<ApiResult<ParcelOrder>> getSingleParcel(num orderId);


  Future<ApiResult<void>> addReview(
      num orderId, {
        required double rating,
        required String comment,
      });
}
