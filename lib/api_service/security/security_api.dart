import 'dart:async';
import 'dart:convert';

import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../dependency/get_it.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/routes.dart';
import '../service.dart';

abstract class SecurityService {
  Future<void> verifyPassword(
      {required String email,
      required String password,
      required BuildContext context});

  Future<void> addPin(
      {required String userPin,
      required String email,
      required BuildContext context});
}

class SecurityImp extends SecurityService {
  static late Response _response;

  SecurityImp();

  @override
  Future<void> addPin(
      {required String userPin,
      required String email,
      required BuildContext context}) async {
    showLoaderDialog(context);

    var userData = {'user_pin': userPin};

    var encodeToJson = jsonEncode(userData);

    try {
      final uri = Uri.https(cxHead, '/profile/add/pin/$email');
      _response = await client
          .post(uri, body: encodeToJson, headers: authorizationHeader)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        throw TimeoutException(errorMessage);
      });

      Navigator.pop(context);
      if (_response.statusCode == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Pin updated successfully');
        debugPrint('Pin updated successfully');
      } else if (_response.statusCode == 409) {
        Fluttertoast.showToast(msg: 'Unable to add pin');
        debugPrint('Unable to add pin');
      }
    } catch (_) {
      debugPrint('Error in adding pin');
    }
  }

  @override
  Future<void> verifyPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    var userData = {'email': email, 'password': password};

    showLoaderDialog(context);

    var encodeToJson = jsonEncode(userData);

    try {
      final uri = Uri.https(cxHead, '/login');
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      Navigator.pop(context);
      if (_response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Password verified');
        getItInstance<NavigationServiceImpl>()
            .replaceWith(Routes.settingsScreen);
        debugPrint('Password verified');
      } else {
        Fluttertoast.showToast(msg: 'Unable to verify password');
        debugPrint('Unable to verify password');
      }
    } catch (_) {
      Fluttertoast.showToast(msg: 'Error in verifying password');
      debugPrint('Error in verifying password');
    }
  }

}
