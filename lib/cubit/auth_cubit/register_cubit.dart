import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_service/auth_api/auth_api.dart';

class RegisterState {
  RegisterState();
}

class RegisterCubit extends Cubit<RegisterState> {
  AuthApiServiceImpl authApiServiceImpl;

  RegisterCubit({required this.authApiServiceImpl}) : super(RegisterState());

  void register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String username,
      required String phoneNumber,
      required String role,
      required BuildContext context}) async {

    Map<String, dynamic> userData = {
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'role': role
    };
    await authApiServiceImpl.signUp(userData: userData, context: context);
    emit(RegisterState());
  }
}
