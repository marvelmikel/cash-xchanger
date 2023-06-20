import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:shared/shared.dart';

import 'package:user/src/data/user_api_calls.dart';
import 'package:user/src/ui/dashboard_home/widget/near_by_vendors_vm.dart';

final userProvider =
    FutureProvider.family<TransactionCharges, String>((ref, cost) async {
  final chagres = await ref.read(userApiProvider).getCharges(cost: cost);
  return chagres;
});


final userDashVM = ChangeNotifierProvider((ref) => UserDashVM(ref));

class UserDashVM extends ChangeNotifier {
  final Ref ref;
  UserDashVM(this.ref);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final amountFormatter =
      CurrencyTextInputFormatter(locale: 'en', symbol: '', decimalDigits: 0);

  bool isVisible = false;
  String cost = '';
  bool tapped = false;

  toggleOnTap() {
    tapped = !tapped;
    if (kDebugMode) {
      print("hit");
    }
    notifyListeners();
  }

  textChange(String value) {
    if (value != '') {
      isVisible = false;
      cost = amountFormatter.getUnformattedValue().toString();
      //  cost = value;
      notifyListeners();
    } else {
      isVisible = true;
      cost = '0';
      notifyListeners();
    }
  }

  goOnline() async {
    bool isServiceEnabled;
    try {
      await Geolocator.requestPermission();
      isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (isServiceEnabled) {
        var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation);

        ref
            .read(nearByVendorVM)
            .setUserLocation(LatLng(position.latitude, position.longitude));
        return ref.read(authService).toggleStatus(OnlineModel(
            isOnline: true,
            isVendor: false,
            long: position.longitude,
            lat: position.latitude));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
