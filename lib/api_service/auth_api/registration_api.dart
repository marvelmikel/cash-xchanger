
import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:cash_xchanger/api_service/profile_api/profile_details_api.dart';
import 'package:cash_xchanger/database/models/auth/Verify_model.dart';
import 'package:cash_xchanger/database/models/profile_model/profile_model.dart';
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
  Future<bool>validateOtp({required VerifyModel payload, required BuildContext context});
  Future<bool>resendOtp({required String email, required BuildContext context});
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
      debugPrint('****** Endpont hit ******');
      debugPrint('****** Request $cxHead/register ******');
      debugPrint('****** Request body $encodeToJson ******');

      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });
      debugPrint('****** Endpoint done ******');
      debugPrint('****** response status code ${_response.statusCode}  ******');
      debugPrint('****** response body  ${_response.body}  ******');
      if (_response.statusCode ==  HttpStatus.created) {
        debugPrint('****** Account created calling profile ******');
        profileDetailsImp
            .profileDetails(email: userData['email'], context: context)
            .then((profile) {
          if (profile != null) {
            getItInstance<NavigationServiceImpl>().pop();
            UserDetails userDetails = profile.userDetails;
            userDetails.userRole == 'user'
                ? getItInstance<NavigationServiceImpl>().navigateTo(
                    Routes.verifyEmailPromptScreen)
                : getItInstance<NavigationServiceImpl>().navigateTo(
                    Routes.vendorWelcomeScreen,
                    arguments: [userDetails.username, userDetails.email]);
            debugPrint('Registration successful');
          } else {
            getItInstance<NavigationServiceImpl>().pop();
            debugPrint('Registration unsuccessful');
            Fluttertoast.showToast(msg: 'Registration unsuccessful');
          }
        });
      }

      if (_response.statusCode ==  HttpStatus.ok) {
        getItInstance<NavigationServiceImpl>().pop();
        debugPrint('Account already exist');
        Fluttertoast.showToast(msg: 'Account already exist');
      }
      if(_response.statusCode == HttpStatus.badRequest){
        getItInstance<NavigationServiceImpl>().pop();
        Fluttertoast.showToast(msg: 'Error processing request');
      }
    } catch (_) {
      debugPrint(_.toString());
      Fluttertoast.showToast(msg: _.toString());
      getItInstance<NavigationServiceImpl>().pop();
    }
  }
  @override
  Future<bool>resendOtp({required String email, required BuildContext context})async{
    var encodeToJson = jsonEncode(email);
    showLoaderDialog(context);
    try {
      final uri = Uri.https(cxHead, '/auth/resend/otp');
      debugPrint('****** Endpont hit ******');
      debugPrint('****** Request $cxHead/auth/resend/otp ******');
      debugPrint('****** Request body $encodeToJson ******');

      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });
      debugPrint('****** Endpoint done ******');
      debugPrint('****** response status code ${_response.statusCode}  ******');
      debugPrint('****** response body  ${_response.body}  ******');
      if (_response.statusCode ==  HttpStatus.created) {
        debugPrint('****** OPT Resent ******');
        getItInstance<NavigationServiceImpl>().pop();
        Fluttertoast.showToast(msg: 'User $email token sent again');
        return true;
      }

      if (_response.statusCode ==  HttpStatus.notFound) {
        getItInstance<NavigationServiceImpl>().pop();
        debugPrint('Account doesnt already exist');
        Fluttertoast.showToast(msg: 'User $email dose not exist');
        return false;
      }
      if(_response.statusCode == HttpStatus.unauthorized){
        getItInstance<NavigationServiceImpl>().pop();
        Fluttertoast.showToast(msg: 'Invalid / Expired Otp');
        return false;
      }
      else{
        getItInstance<NavigationServiceImpl>().pop();
        Fluttertoast.showToast(msg: 'Something went wrong');
        return false;
      }
    } catch (_) {
      debugPrint(_.toString());
      Fluttertoast.showToast(msg: _.toString());
      getItInstance<NavigationServiceImpl>().pop();
      return false;
    }


  }

  @override
  Future<bool>validateOtp({required VerifyModel payload, required BuildContext context} ) async {
    var encodeToJson = jsonEncode(payload.toJson());

    showLoaderDialog(context);

    try {
      final uri = Uri.https(cxHead, '/auth/verify');
      debugPrint('****** Endpont hit ******');
      debugPrint('****** Request $cxHead/auth/verify ******');
      debugPrint('****** Request body $encodeToJson ******');

      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });
      debugPrint('****** Endpoint done ******');
      debugPrint('****** response status code ${_response.statusCode}  ******');
      debugPrint('****** response body  ${_response.body}  ******');
      if (_response.statusCode ==  HttpStatus.ok) {
        debugPrint('****** OPT Verified ******');
        getItInstance<NavigationServiceImpl>().pop();
        getItInstance<NavigationServiceImpl>()
            .navigateTo(Routes.confirmationScreen,
            arguments: '');
        return true;
      }

      if (_response.statusCode ==  HttpStatus.notFound) {
        getItInstance<NavigationServiceImpl>().pop();
        debugPrint('Account already exist');
        Fluttertoast.showToast(msg: 'User with Email dose not exist');
        return false;
      }
      if(_response.statusCode == HttpStatus.unauthorized){
        getItInstance<NavigationServiceImpl>().pop();
        Fluttertoast.showToast(msg: 'Invalid / Expired Otp');
        return false;
      }
      else{
        getItInstance<NavigationServiceImpl>().pop();

        Fluttertoast.showToast(msg: 'Something went wrong');
        return false;
      }
    } catch (_) {
      debugPrint(_.toString());
      Fluttertoast.showToast(msg: _.toString());
      getItInstance<NavigationServiceImpl>().pop();
      return false;
    }
  }
}
