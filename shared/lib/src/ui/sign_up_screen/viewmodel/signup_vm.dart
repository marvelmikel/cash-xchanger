import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/src/datasource/auth/auth_datasource.dart';

import '../../../../shared.dart';
import '../models/register_model.dart';
import '../models/verify_model.dart';

final signupVM = ChangeNotifierProvider((ref) => SignUpVM(ref));

class SignUpVM extends ChangeNotifier {
  final Ref _ref;
  SignUpVM(this._ref);
  String phone = '';
  final TempStorage prefs = TempStorage.instance;
  setPhone(String value) {
    phone = value;
    notifyListeners();
  }

  void register(
      {required RegisterModel payload, required BuildContext context}) async {
    try {
      showLoaderDialog(context);
      print("this is the payload ${payload.toJson()}");
      final response = await _ref.read(authService).signUpUser(
            payload,
          );

      response.fold((l) {
        _ref.read(navProvider).pop();
        alert(description: l.first.message);
      }, (r) {
        _ref.read(navProvider).pop();
        print("Done");
        setPhone(payload.phoneNumber!);
        _ref.read(navProvider).navigateTo(Routes.verifyPhoneScreen);
      });


    } catch (err) {
      _ref.read(navProvider).pop();
    }
  }

  void resendOtp({required BuildContext context}) async {
    try {
      showLoaderDialog(context);
      final response = await _ref.read(authService).resendOtp(
            VerifyModel(phoneNumber: phone),
          );
      response.fold((l) {
        alert(description: l.first.message);
      }, (r) {
        alert(description: "Code Resent", type: "success");
      });

      _ref.read(navProvider).pop();
    } catch (err) {
      _ref.read(navProvider).pop();
    }
  }

  Future<void> validateOtp(
      {required String code, required BuildContext context}) async {
    try {
      showLoaderDialog(context);
      final response = await _ref.read(authService).validateOtp(
            VerifyModel(phoneNumber: phone, code: code),
          );

      response.fold((l) {
        alert(description: l.first.message);
      }, (r) {
        print("this is the response $r");
        _ref.read(navProvider).pop();
        final res = Response.fromJson(r).userCollection!.userLogin;
        prefs.saveAuthToken(authToken: res!.token!);
        final user = res.user;
        if (user!.role == 'user') {

          _ref.read(navProvider).navigateTo(Routes.confirmationScreen);
        } else {
          _ref.read(navProvider).navigateTo(
               Routes.vendorKycScreen);
        }
      });


    } catch (err) {
      _ref.read(navProvider).pop();
      print("this is the err $err");
    }
  }

  readPrivacy() =>
      _ref.read(navProvider).navigateTo(Routes.privacyScreen, arguments: '');
}
