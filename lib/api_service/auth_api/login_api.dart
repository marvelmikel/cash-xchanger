import 'dart:async';
import 'dart:convert';

import 'package:cash_xchanger/database/models/profile_model/profile_model.dart';
import 'package:cash_xchanger/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../database/models/auth/login_model.dart';
import '../../dependency/get_it.dart';
import '../../helpers/helpers.dart';
import '../../navigation/routes.dart';
import '../profile_api/profile_details_api.dart';
import '../service.dart';

abstract class LoginApiService {
  Future<void> userLogin(
      {required LoginModel payload, required BuildContext context});
}

class LoginServiceImpl extends LoginApiService {
  late Response _response;
  late ProfileDetailsImp profileDetailsImp;
  LoginServiceImpl({required this.profileDetailsImp});

  @override
  Future<void> userLogin(
      {required LoginModel payload, required BuildContext context}) async {
    showLoaderDialog(context);

    var encodeToJson = jsonEncode(payload.toJson());

    try {
      final uri = Uri.https(cxHead, '/login');
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        context.read<NavigationServiceImpl>().pop();
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        profileDetailsImp
            .profileDetails(email: payload.email!, context: context)
            .then((profile) {
          if (profile != null) {
            getItInstance<NavigationServiceImpl>().pop();
            debugPrint("${profile}");
            UserDetails details = profile.userDetails;
            details.userRole == 'user'
                ? getItInstance<NavigationServiceImpl>().replaceUntil(
                    context: context,
                    routeName: Routes.userDashBoard,
                    arguments: details.username ?? '',
                  )
                : details.isDocumentVerified
                    ? getItInstance<NavigationServiceImpl>().replaceUntil(
                        context: context, routeName: Routes.vendorDashboard)
                    : getItInstance<NavigationServiceImpl>().navigateTo(
                        Routes.vendorWelcomeScreen,
                        arguments: [details.username, details.email]);
            debugPrint('Login successful');
          } else {
            getItInstance<NavigationServiceImpl>().pop();
            debugPrint('Login unsuccessful');
            Fluttertoast.showToast(msg: 'Unable to login, try again');
          }
        });
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
