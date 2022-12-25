import 'package:cash_xchanger/api_service/auth_api/registration_api.dart';
import 'package:cash_xchanger/api_service/auth_api/reset_api.dart';
import 'package:flutter/cupertino.dart';

import '../../database/models/auth/login_model.dart';
import 'login_api.dart';

abstract class AuthApiService {
  Future<void> login(
      {required LoginModel payload, required BuildContext context});

  Future<void> signUp({required userData, required BuildContext context});
  Future<void> initReset(
      {required String email, required BuildContext context});
  Future<void> resetPassword(
      {required String password,
      required String confirmPassword,
      required BuildContext context});
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
      {required userData, required BuildContext context}) async {
    registrationServiceImpl.userReg(userData: userData, context: context);
  }

  @override
  Future<void> login({
    required LoginModel payload,
    required BuildContext context,
  }) async {
    loginServiceImpl.userLogin(payload: payload, context: context);
  }

  @override
  Future<void> initReset(
          {required String email, required BuildContext context}) =>
      resetApiService.intReset(email: email, context: context);

  @override
  Future<void> resetPassword(
          {required String password,
          required String confirmPassword,
          required BuildContext context}) =>
      resetApiService.resetPassword(
          password: password,
          confirmPassword: confirmPassword,
          context: context);
}
