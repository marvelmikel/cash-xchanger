import 'package:cash_xchanger/api_service/auth_api/registration_api.dart';
import 'package:flutter/cupertino.dart';

import 'login_api.dart';

abstract class AuthApiService {
  Future<void> login(
      {required String email,
      required BuildContext context,
      required String password});

  Future<void> signUp({required userData, required BuildContext context});
}

class AuthApiServiceImpl extends AuthApiService {
  RegistrationServiceImpl registrationServiceImpl;
  LoginServiceImpl loginServiceImpl;

  AuthApiServiceImpl(
      {required this.loginServiceImpl, required this.registrationServiceImpl});

  @override
  Future<void> signUp(
      {required userData, required BuildContext context}) async {
    registrationServiceImpl.userReg(userData: userData, context: context);
  }

  @override
  Future<void> login(
      {required String email,
      required BuildContext context,
      required String password}) async {
    loginServiceImpl.userLogin(
        email: email, password: password, context: context);
  }
}
