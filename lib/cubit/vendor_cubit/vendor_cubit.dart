import 'dart:async';

import 'package:cash_xchanger/ui/vendor/vendor_dashboard/online_vendor_cash_type.dart';
import 'package:cash_xchanger/ui/vendor/vendor_dashboard/switch_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../api_service/nearby_vendor/nearby_vendor_api.dart';
import '../../database/shared_preferences/temp_database.dart';

class VendorState {
  VendorState();
}

class VendorCubit extends Cubit<VendorState> {
  TempDataBaseImpl tempDataBaseImpl;
  NearbyVendorApiServiceImpl nearbyVendorApiServiceImpl;
  Timer? countdownTimer;

  VendorCubit(
      {required this.tempDataBaseImpl,
      required this.nearbyVendorApiServiceImpl})
      : super(VendorState());

  void changeOnlineStatus({required BuildContext context}) async {
    bool isServiceEnabled;

    await Geolocator.requestPermission();
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isServiceEnabled) {
      if (isUserOnline.value) {
        countdownTimer?.cancel();
        isUserOnline.value = !isUserOnline.value;
        _offLine(context: context);
      } else {
        showDialog(
            context: context,
            builder: (context) => const OnlineVendorCashType());
      }
    }
  }

  void online({required BuildContext context, cashType}) {
    nearbyVendorApiServiceImpl
        .onlineVendor(context: context, isOnline: true, cashType: cashType)
        .then((value) {
      isUserOnline.value = true;
    });
    countdownTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      nearbyVendorApiServiceImpl
          .onlineVendor(context: context, isOnline: true, cashType: cashType)
          .then((value) {});
    });
  }

  void _offLine({required BuildContext context}) {
    nearbyVendorApiServiceImpl
        .onlineVendor(context: context, isOnline: false, cashType: 'mint')
        .then((value) {
      isUserOnline.value = !isUserOnline.value;
    });
  }
}
