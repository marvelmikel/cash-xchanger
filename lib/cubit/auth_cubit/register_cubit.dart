import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_service/auth_api/auth_api.dart';
import '../../database/models/auth/register_model.dart';
import '../../dependency/get_it.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/routes.dart';

class RegisterState {
  RegisterState();
}

class RegisterCubit extends Cubit<RegisterState> {
  AuthApiServiceImpl authApiServiceImpl;

  RegisterCubit({required this.authApiServiceImpl}) : super(RegisterState());

  void register(
      {required RegisterModel payload, required BuildContext context}) async {
    await authApiServiceImpl.signUp(
        userData: payload.toJson(), context: context);
    emit(RegisterState());
  }
}
