import 'package:cash_xchanger/api_service/auth_api/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/models/terms_and_conditions/terms.dart';

abstract class PrivacyState{

  PrivacyState();
}
class PrivacyLoadedState extends PrivacyState {
  PrivacyLoadedState(this.termsModel) : super();

  TermsModel? termsModel;
}

class PrivacyLoadingState extends PrivacyState {
  PrivacyLoadingState(): super();
}

class PrivacyInitialState extends PrivacyState {
  PrivacyInitialState(): super();
}

class PrivacyErrorState extends PrivacyState {
  PrivacyErrorState() : super();
}

class PrivacyCubit extends Cubit<PrivacyState> {
  AuthApiServiceImpl authApiServiceImpl;
  PrivacyCubit({required this.authApiServiceImpl}) : super(PrivacyInitialState());
   loadPrivacy() async {
    debugPrint('I was hit to make call');
    try {
      emit(PrivacyLoadingState());
      final data =
      await authApiServiceImpl.fetchPrivacyPolicy();
     if (data != null) {
         emit(PrivacyLoadedState(data));
      } else {
        emit(PrivacyErrorState());
      }
    } catch (err, stack) {
      debugPrint('tis the error $err with stack trace of $stack');
      emit(PrivacyErrorState());
    }
  }
}

