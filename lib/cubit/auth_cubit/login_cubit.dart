import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_service/auth_api/auth_api.dart';
import '../../database/models/auth/login_model.dart';

class LoginState {
  LoginState();
}

class LoginCubit extends Cubit<LoginState> {
  AuthApiServiceImpl authApiServiceImpl;

  LoginCubit({required this.authApiServiceImpl}) : super(LoginState());

  void login(
      {required LoginModel payload, required BuildContext context}) async {
    await authApiServiceImpl.login(context: context, payload: payload);
    emit(LoginState());
  }
}
