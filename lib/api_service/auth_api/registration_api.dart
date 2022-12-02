import 'dart:async';
import 'dart:convert';

import 'package:cash_xchanger/api_service/profile_api/profile_details_api.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../dependency/get_it.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/routes.dart';
import '../service.dart';

abstract class RegistrationService {
  Future<void> userReg(
      {required Map<String, dynamic> userData, required BuildContext context});
}

class RegistrationServiceImpl extends RegistrationService {
  late Response _response;

  ProfileDetailsImp profileDetailsImp;

  RegistrationServiceImpl({required this.profileDetailsImp});

  @override
  Future<void> userReg(
      {required Map<String, dynamic> userData,
      required BuildContext context}) async {
    var encodeToJson = jsonEncode(userData);

    showLoaderDialog(context);

    try {
      final uri = Uri.https(cxHead, '/register');
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 201) {
        profileDetailsImp
            .profileDetails(email: userData['email'], context: context)
            .then((value) {
          if (value) {
            getItInstance<NavigationServiceImpl>().pop();
            userData['role'] == 'user'
                ? getItInstance<NavigationServiceImpl>().navigateTo(
                    Routes.confirmationScreen,
                    arguments: userData['username'] ?? '')
                : getItInstance<NavigationServiceImpl>().navigateTo(
                    Routes.vendorWelcomeScreen,
                    arguments: [userData['username'], userData['email']]);
            debugPrint('Registration successful');
          } else {
            getItInstance<NavigationServiceImpl>().pop();
            debugPrint('Registration unsuccessful');
            Fluttertoast.showToast(msg: 'Registration unsuccessful');
          }
        });
      }

      if (_response.statusCode == 200) {
        getItInstance<NavigationServiceImpl>().pop();
        debugPrint('Account already exist');
        Fluttertoast.showToast(msg: 'Account already exist');
      }
    } catch (_) {
      getItInstance<NavigationServiceImpl>().pop();
    }
  }
}
