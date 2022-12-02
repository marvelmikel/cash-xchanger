import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_service/auth_api/auth_api.dart';

class LoginState {
  LoginState();
}

class LoginCubit extends Cubit<LoginState> {
  AuthApiServiceImpl authApiServiceImpl;

  LoginCubit({required this.authApiServiceImpl}) : super(LoginState());

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    await authApiServiceImpl.login(
        email: email, password: password, context: context);
    emit(LoginState());
  }
}
