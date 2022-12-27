import 'package:cash_xchanger/api_service/auth_api/registration_api.dart';
import 'package:cash_xchanger/api_service/auth_api/reset_api.dart';
import 'package:cash_xchanger/database/models/auth/reset_model.dart';
import 'package:cash_xchanger/database/models/auth/verify_model.dart';
import 'package:flutter/cupertino.dart';

import '../../database/models/auth/login_model.dart';
import '../../database/models/terms_and_conditions/terms.dart';
import 'login_api.dart';

abstract class AuthApiService {
  Future<void> login(
      {required LoginModel payload, required BuildContext context});

  Future<void> signUp({required userData, required BuildContext context});
  Future<void> initReset(
      {required String email, required BuildContext context});
  Future<void> resetPassword(
      {required  ResetModel payload,
      required BuildContext context});
  Future<bool> validateOtp(
      {required VerifyModel payload, required BuildContext context});
  Future<bool> resendOtp(
      {required String email, required BuildContext context});
  Future<TermsModel?> fetchPrivacyPolicy();
}

class AuthApiServiceImpl extends AuthApiService {
  RegistrationServiceImpl registrationServiceImpl;
  LoginServiceImpl loginServiceImpl;
  ResetApiService resetApiService;

  AuthApiServiceImpl(
      {required this.loginServiceImpl,
      required this.registrationServiceImpl,
      required this.resetApiService});

  @override
  Future<void> signUp(
          {required userData, required BuildContext context}) async =>
      registrationServiceImpl.userReg(userData: userData, context: context);

  @override
  Future<void> login({
    required LoginModel payload,
    required BuildContext context,
  }) async =>
      loginServiceImpl.userLogin(payload: payload, context: context);

  @override
  Future<void> initReset(
          {required String email, required BuildContext context}) =>
      resetApiService.intReset(email: email, context: context);

  @override
  Future<void> resetPassword(
          {required ResetModel payload,
          required BuildContext context}) =>
      resetApiService.resetPassword(
          payload: payload,
          context: context);

  @override
  Future<bool> resendOtp(
          {required String email, required BuildContext context}) =>
      registrationServiceImpl.resendOtp(email: email, context: context);

  @override
  Future<bool> validateOtp(
          {required VerifyModel payload, required BuildContext context}) =>
      registrationServiceImpl.validateOtp(payload: payload, context: context);
  @override
  Future<TermsModel?> fetchPrivacyPolicy() async =>
      await registrationServiceImpl.fetchPrivacyPolicy();
}
