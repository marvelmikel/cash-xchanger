import 'dart:async';
import 'dart:convert';

import 'package:cash_xchanger/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../dependency/get_it.dart';
import '../../helpers/helpers.dart';
import '../service.dart';

abstract class ResetApiService {
  Future<void> intReset({required String email, required BuildContext context});
  Future<void> resetPassword(
      {required String password,
      required String confirmPassword,
      required BuildContext context});
}

class ResetServiceImpl extends ResetApiService {
  late Response _response;

  ResetServiceImpl();

  @override
  Future<void> intReset(
      {required String email, required BuildContext context}) async {
    showLoaderDialog(context);

    var encodeToJson = jsonEncode(email);

    ///fecom35835@khaxan.com
    try {
      final uri = Uri.https(cxHead, '/reset');
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        context.read<NavigationServiceImpl>().pop();
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        getItInstance<NavigationServiceImpl>().pop();
      } else {
        Fluttertoast.showToast(msg: 'Incorrect Username or Password');
        getItInstance<NavigationServiceImpl>().pop();
      }
    } catch (_) {
      debugPrint(_.toString());
      getItInstance<NavigationServiceImpl>().pop();
    }
  }

  @override
  Future<void> resetPassword(
      {required String password,
      required String confirmPassword,
      required BuildContext context}) async {
    showLoaderDialog(context);

    var encodeToJson = jsonEncode("email");

    try {
      final uri = Uri.https(cxHead, '/reset');
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        context.read<NavigationServiceImpl>().pop();
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        getItInstance<NavigationServiceImpl>().pop();
      } else {
        Fluttertoast.showToast(msg: 'Incorrect Username or Password');
        getItInstance<NavigationServiceImpl>().pop();
      }
    } catch (_) {
      debugPrint(_.toString());
      getItInstance<NavigationServiceImpl>().pop();
    }
  }
}
