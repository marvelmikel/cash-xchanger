import 'package:cash_xchanger/database/models/auth/verify_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api_service/auth_api/auth_api.dart';
import '../../database/models/auth/register_model.dart';

import '../../navigation/navigation.dart';

class RegisterState {
  RegisterState();
}

class OtpState extends RegisterState {
  OtpState();
}

class ValidateOtpState extends RegisterState {
  ValidateOtpState();
}



class RegisterCubit extends Cubit<RegisterState> {
  AuthApiServiceImpl authApiServiceImpl;

  RegisterCubit({required this.authApiServiceImpl}) : super(RegisterState());

  void register(
          {required RegisterModel payload,
          required BuildContext context}) async =>
      await authApiServiceImpl
          .signUp(userData: payload.toJson(), context: context)
          .then((value) => emit(RegisterState()));

  void resendOtp(
          {required String email, required BuildContext context}) async =>
      await authApiServiceImpl
          .resendOtp(email: email, context: context)
          .then((value) => emit(OtpState()));

  Future<void> validateOtp(
          {required VerifyModel payload,
          required BuildContext context}) async =>
      await authApiServiceImpl
          .validateOtp(payload: payload, context: context)
          .then((value) => emit(ValidateOtpState()));

  readPrivacy() {
    getItInstance<NavigationServiceImpl>()
        .navigateTo(Routes.privacyScreen, arguments: '');
  }

}
