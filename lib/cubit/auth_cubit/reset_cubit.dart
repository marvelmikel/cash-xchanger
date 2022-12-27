import 'package:cash_xchanger/api_service/auth_api/auth_api.dart';
import 'package:cash_xchanger/database/models/auth/reset_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetState {
  ResetState();
}

class ResetCubit extends Cubit<ResetState> {
  AuthApiServiceImpl authApiServiceImpl;

  ResetCubit({required this.authApiServiceImpl}) : super(ResetState());

  void initReset({required String email, required BuildContext context}) async {
    await authApiServiceImpl.initReset(context: context, email: email);
    emit(ResetState());
  }

  void resetPassword(
      {required ResetModel payload,
      required BuildContext context}) async {
    await authApiServiceImpl.resetPassword(
        payload: payload, context: context);
    emit(ResetState());
  }
}
