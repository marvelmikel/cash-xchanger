import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cash_xchanger/database/models/auth/reset_model.dart';
import 'package:cash_xchanger/ui/confirmation_screen/email_verification_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../database/models/auth/auth_response.dart';
import '../../dependency/get_it.dart';
import '../../helpers/helpers.dart';
import '../../navigation/navigation.dart';
import '../service.dart';

abstract class ResetApiService {
  Future<void> intReset({required String email, required BuildContext context});
  Future<void> resetPassword(
      {required ResetModel payload, required BuildContext context});
}

class ResetServiceImpl extends ResetApiService {
  late Response _response;

  ResetServiceImpl();

  @override
  Future<void> intReset(
      {required String email, required BuildContext context}) async {
    showLoaderDialog(context);
    Map<String, dynamic> body = {'email': email};
    var encodeToJson = jsonEncode(body);

    try {
      final uri = Uri.https(cxHead, '/auth/send/otp');
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        context.read<NavigationServiceImpl>().pop();
        throw TimeoutException(errorMessage);
      });
      AuthReqResponse res =
          AuthReqResponse.fromJson(json.decode(_response.body));
      if (_response.statusCode == HttpStatus.created) {
        getItInstance<NavigationServiceImpl>()
            .navigateTo(Routes.verifyEmailScreen, arguments: PinType.reset);
      } else {
        Fluttertoast.showToast(msg: res.message!);
        getItInstance<NavigationServiceImpl>().pop();
      }
    } catch (_) {
      debugPrint(_.toString());
      Fluttertoast.showToast(msg: 'Something went wrong');
      getItInstance<NavigationServiceImpl>().pop();
    }
  }

  @override
  Future<void> resetPassword(
      {required ResetModel payload, required BuildContext context}) async {
    showLoaderDialog(context);
    debugPrint('${payload.toJson()}');
    var encodeToJson = jsonEncode(payload.toJson());

    try {
      final uri = Uri.https(cxHead, '/auth/reset_password');
      _response = await client
          .patch(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        context.read<NavigationServiceImpl>().pop();
        throw TimeoutException(errorMessage);
      });
      AuthReqResponse res =
          AuthReqResponse.fromJson(json.decode(_response.body));
      if (_response.statusCode == 200) {
        getItInstance<NavigationServiceImpl>().pop();
        Fluttertoast.showToast(msg: res.message!);
        getItInstance<NavigationServiceImpl>()
            .replaceUntil(context: context, routeName: Routes.overViewScreen);
      } else {
        Fluttertoast.showToast(msg: res.message!);
        getItInstance<NavigationServiceImpl>().pop();
      }
    } catch (_) {
      debugPrint(_.toString());
      getItInstance<NavigationServiceImpl>().pop();
    }
  }
}
