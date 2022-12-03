import 'dart:async';
import 'dart:convert';

import 'package:cash_xchanger/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../dependency/get_it.dart';
import '../../helpers/helpers.dart';
import '../../navigation/routes.dart';
import '../profile_api/profile_details_api.dart';
import '../service.dart';

abstract class LoginApiService {
  Future<void> userLogin(
      {required email, required password, required BuildContext context});
}

class LoginServiceImpl extends LoginApiService {
  late Response _response;
  late ProfileDetailsImp profileDetailsImp;

  LoginServiceImpl({required this.profileDetailsImp});

  @override
  Future<void> userLogin(
      {required email,
      required password,
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
        context.read<NavigationServiceImpl>().pop();
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {

        profileDetailsImp
            .profileDetails(email: userData['email'], context: context)
            .then((value) {
          var body = jsonDecode(_response.body);
          if (value) {
            getItInstance<NavigationServiceImpl>().pop();
            body['User Details']['role'] == 'user'
                ? getItInstance<NavigationServiceImpl>().replaceUntil(
                    context: context,
                    routeName: Routes.userDashBoard,
                    arguments: userData['username'] ?? '',
                  )
                : body['User Details']['is_document_verified']
                    ? getItInstance<NavigationServiceImpl>().replaceUntil(
                        context: context, routeName: Routes.vendorDashboard)
                    : getItInstance<NavigationServiceImpl>().navigateTo(
                        Routes.vendorWelcomeScreen,
                        arguments: [userData['username'], userData['email']]);
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
