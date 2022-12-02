import 'dart:async';
import 'dart:convert';

import 'package:cash_xchanger/database/models/temp_cash_model/temp_cash_model.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../../database/models/profile_model/profile_model.dart';
import '../../database/shared_preferences/temp_database.dart';
import '../../dependency/get_it.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/routes.dart';
import '../../ui/user/dashboard/book_cash/book_cash_screen.dart';
import '../service.dart';

abstract class NearbyVendorApiService {
  Future<bool> searchNearbyVendors(
      {required String email,
      required BuildContext context,
      required Map<String, dynamic> cashData});

  Future<void> confirmBooking({required BuildContext context});

  Future<void> cancelBooking({required BuildContext context});

  Future<void> completeTransaction({required BuildContext context});

  Future<void> scheduleDeliveryLater(
      {required BuildContext context, required Map<String, dynamic> cashData});

  Future<bool> onlineVendor(
      {required BuildContext context,
      required cashType,
      required bool isOnline});
}

class NearbyVendorApiServiceImpl extends NearbyVendorApiService {
  TempDataBaseImpl tempDataBaseImpl;

  NearbyVendorApiServiceImpl({required this.tempDataBaseImpl});

  late Response _response;

  @override
  Future<bool> searchNearbyVendors(
      {required String email,
      required BuildContext context,
      required Map<String, dynamic> cashData}) async {
    var encodeToJson = jsonEncode(cashData);

    try {
      final uri = Uri.https(
          cxHead,
          '/vendor/find/vendors/nearby/'
          '$email',
          {
            'MasterAPIKey':
                'Qpieg2eKkXSAU1FCK7agQu2ohaT2YHHiLNHjE4BoQmvhQxIRKkg6F'
          });
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Navigator.pop(context);
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'A vendor has been found');
        debugPrint('A vendor has been found');

        var tempData = tempCashModelFromMap(_response.body);
        tempDataBaseImpl.saveUnfinishedTransaction(
            transaction: tempCashModelToMap(tempData));
        getItInstance<NavigationServiceImpl>().pop();
        getItInstance<NavigationServiceImpl>().replaceWith(
            Routes.requestCashScreen,
            arguments: [cashData['lat'], cashData['long']]);
        switchCards.value = true;

        return true;
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'No nearby vendor at the moment');
        debugPrint('No nearby vendor at the moment');
        debugPrint('Lat :${cashData['lat']}');
        debugPrint('Long :${cashData['long']}');
        return false;
      }
    } catch (_) {
      Navigator.pop(context);
      debugPrint('Error $_');
      return false;
    }
  }

  @override
  Future<void> confirmBooking({required BuildContext context}) async {
    var tempTransaction =
        tempCashModelFromMap(tempDataBaseImpl.getUnfinishedTransaction());
    var profile =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;

    showLoaderDialog(context);

    var userData = {
      'transaction_reference': tempTransaction.nearestVendors.transactionRef,
      'response': 'accepted'
    };

    var encodeToJson = jsonEncode(userData);

    try {
      final uri = Uri.https(
          cxHead,
          '/payment/book-cash/${profile.userRole}/accept/${profile.email}',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Navigator.pop(context);
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      Navigator.pop(context);

      if (_response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Booking confirmed');
        debugPrint('Booking confirmed');
        tempDataBaseImpl.removeUnfinishedCashOrder();
        tempDataBaseImpl.confirmedCashBooking();
        switchCards.value = false;
      } else {
        Fluttertoast.showToast(msg: 'Unable confirm booking');
        debugPrint('Unable confirm booking');
      }
    } catch (_) {
      Fluttertoast.showToast(msg: 'Error in confirming booking');
      debugPrint('Error in confirming booking');
    }
  }

  @override
  Future<void> completeTransaction({required BuildContext context}) async {
    var tempTransaction =
        tempCashModelFromMap(tempDataBaseImpl.getUnfinishedTransaction());
    var profile =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;

    showLoaderDialog(context);

    var userData = {
      'transaction_reference': tempTransaction.nearestVendors.transactionRef
    };

    var encodeToJson = jsonEncode(userData);

    try {
      final uri = Uri.https(
          cxHead,
          '/payment/book-cash/complete/${profile.email}',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Navigator.pop(context);
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      Navigator.pop(context);
      if (_response.statusCode == 200) {
        getItInstance<NavigationServiceImpl>().navigateTo(Routes.successScreen,
            arguments: 'Cash successfully exchanged');
        debugPrint('Cash successfully exchanged');
      } else {
        Fluttertoast.showToast(
            msg: 'The other party has to accept this order first');
        debugPrint('The other party has to accept this order first');
        Navigator.pop(context);
      }
    } catch (_) {
      Fluttertoast.showToast(msg: 'Error in completing order');
      debugPrint('Error in completing order');
    }
  }

  @override
  Future<void> scheduleDeliveryLater(
      {required BuildContext context,
      required Map<String, dynamic> cashData}) async {
    var profile =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;

    showLoaderDialog(context);

    var encodeToJson = jsonEncode(cashData);

    try {
      final uri = Uri.https(
          cxHead,
          '/payment/scheduled-payments/add/${profile.email}',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Navigator.pop(context);
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      Navigator.pop(context);
      if (_response.statusCode == 200) {
        getItInstance<NavigationServiceImpl>().navigateTo(Routes.successScreen,
            arguments: 'Cash scheduled successfully');
        debugPrint('Cash scheduled successfully');
      } else {
        Fluttertoast.showToast(
            msg: 'Unable to schedule cash, please try again later');
        debugPrint('Unable to schedule cash, please try again later');
      }
    } catch (_) {
      Fluttertoast.showToast(msg: 'Error in completing scheduling cash');
      debugPrint('Error in completing scheduling cash \n$_');
    }
  }

  @override
  Future<bool> onlineVendor(
      {required BuildContext context, cashType, required bool isOnline}) async {
    showLoaderDialog(context);

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    var profile =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;

    var userData = {
      'lat': position.latitude,
      'long': position.longitude,
      'vendor_status': isOnline,
      'cash_type': cashType
    };

    var encodeToJson = jsonEncode(userData);

    try {
      final uri = Uri.https(cxHead, '/vendor/${profile.email}/is-online', {
        'MasterAPIKey': 'Qpieg2eKkXSAU1FCK7agQu2ohaT2YHHiLNHjE4BoQmvhQxIRKkg6F'
      });
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Navigator.pop(context);
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      Navigator.pop(context);
      Navigator.pop(context);

      if (_response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'You status have been updated');
        debugPrint('You status have been updated');
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Unable to set status');
        debugPrint('Unable to set status');
        return false;
      }
    } catch (_) {
      Fluttertoast.showToast(msg: 'Error in setting status');
      debugPrint('Error in setting status');
      return false;
    }
  }

  @override
  Future<void> cancelBooking({required BuildContext context}) async {
    Navigator.pop(context);
    tempDataBaseImpl.resetConfirmedCashBooking();
    tempDataBaseImpl.removeUnfinishedCashOrder();
    tempDataBaseImpl.removeUnfinishedTransaction();
  }
}
