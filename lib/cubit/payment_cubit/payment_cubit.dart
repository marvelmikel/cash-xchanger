import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_service/payments_api/bank_service_api.dart';
import '../../api_service/payments_api/top_up_api.dart';
import '../../database/models/banks_model/bank_info_model.dart';
import '../../database/models/profile_model/profile_model.dart';
import '../../database/shared_preferences/temp_database.dart';

class PaymentState {
  List<BankInfoModel> bankList;
  BankInfoModel bankInfoModel;

  PaymentState({required this.bankList, required this.bankInfoModel});
}

class PaymentCubit extends Cubit<PaymentState> {
  BankImpl bankImpl;
  TopUpImpl topUpImpl;
  TempDataBaseImpl tempDataBaseImpl;

  PaymentCubit(
      {required this.bankImpl,
      required this.tempDataBaseImpl,
      required this.topUpImpl})
      : super(PaymentState(
            bankList: [],
            bankInfoModel: BankInfoModel(
                bankName: 'Bank name',
                bankCode: '',
                accountNumber: '',
                accountName: '')));

  void addCardDetails(
      {required BuildContext context,
      required String cardNumber,
      required String expDate,
      required String cvv}) {
    var userData =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;

    var cardInfo = {
      'card_number': cardNumber,
      'card_name': '${userData.firstName} ${userData.lastName}',
      'expiry': expDate,
      'cvv': cvv,
      'payment_type': 1
    };

    bankImpl.addCardDetails(
        cardDetails: cardInfo, email: userData.email, context: context);
  }

  void getNigerianBanks() {
    bankImpl.getNigerianBanks().then((value) => emit(
        PaymentState(bankList: value, bankInfoModel: state.bankInfoModel)));
  }

  void topUp({required String amount, required BuildContext context}) {
    var userData =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;
    topUpImpl.topUp(email: userData.email, amount: amount, context: context);
  }

  void resetState() {
    emit(PaymentState(
        bankList: [],
        bankInfoModel: BankInfoModel(
            bankName: 'Bank name',
            bankCode: '',
            accountNumber: '',
            accountName: '')));
  }

  void addBank({required BuildContext context}) {
    var userData =
        profileModelFromMap(tempDataBaseImpl.getUserData()).userDetails;
    var bankDetails = {
      'account_name': state.bankInfoModel.accountName,
      'bank': state.bankInfoModel.bankName,
      'bank_account_no': state.bankInfoModel.accountNumber,
      'payment_type': 2
    };
    bankImpl.addBank(
        bankDetails: bankDetails, email: userData.email, context: context);
  }

  void verifyAccountNumber(
      {required accountNumber,
      required bankName,
      required bankCode,
      required BuildContext context}) {
    bankImpl
        .verifyAccountNumber(
            accountNumber: accountNumber,
            bankName: bankName,
            bankCode: bankCode,
            context: context)
        .then((value) =>
            emit(PaymentState(bankList: state.bankList, bankInfoModel: value)));
  }
}
