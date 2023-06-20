import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared/shared.dart';
import 'package:vendor/src/data/vendor_api_service.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

final vendorDashboardVM = ChangeNotifierProvider((ref) => VendorDashVM(ref));

class VendorDashVM extends ChangeNotifier {
  final Ref ref;
  VendorDashVM(this.ref);
  final cashController = TextEditingController();
  bool positive = false;
  bool isEditing = false;
  double cashAtHand = 0.0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final amountFormatter =
  CurrencyTextInputFormatter(locale: 'en', symbol: '', decimalDigits: 0);
  toggleVendorState(bool value) async {
    positive = value;
    notifyListeners();
    bool isServiceEnabled;
    try {
      await Geolocator.requestPermission();
      isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (isServiceEnabled) {
        var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation);
        return ref.read(authService).toggleStatus(OnlineModel(
            isOnline: positive,
            isVendor: true,
            long: position.longitude,
            lat: position.latitude));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  toggleEditing(BuildContext context) async {
    isEditing = !isEditing;

    if (cashController.text.isNotEmpty) {
      cashAtHand = double.parse(cashController.text);
      showLoaderDialog(context);
      try {
        final response = await
            ref.read(vendorApiService).setCashAtHand(amount: cashAtHand);
        response.fold((l) {
          ref.read(navProvider).pop();
          alert(description: l.first.message);
        }, (r) {
          ref.read(navProvider).pop();
          ref.read(profileViewModelProviderV1).setUserMode =
              Response.fromJson(r).userCollection!.user!;
          alert(description: "Current Balance Updated", type: 'good');
        });
      } catch (e,s) {
        ref.read(navProvider).pop();
      }
    }

    cashController.clear();
    notifyListeners();
  }
}
