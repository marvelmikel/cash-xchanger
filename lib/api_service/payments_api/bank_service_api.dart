import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../cubit/nav_bar_cubit/nav_drawer_cubit.dart';
import '../../cubit/payment_cubit/payment_cubit.dart';
import '../../database/models/banks_model/bank_info_model.dart';
import '../../helpers/helpers.dart';
import '../../ui/global_widgets/bank_bottom_sheet/search_text_field.dart';
import '../service.dart';

abstract class BankService {
  Future<void> addCardDetails(
      {required cardDetails,
      required String email,
      required BuildContext context});

  Future<void> addBank(
      {required bankDetails,
      required String email,
      required BuildContext context});

  Future<List<BankInfoModel>> getNigerianBanks();

  Future<BankInfoModel> verifyAccountNumber(
      {required String accountNumber,
      required bankCode,
      required bankName,
      required BuildContext context});
}

class BankImpl implements BankService {
  late Response _response;
  final payStackEndpoint = 'api.paystack.co';
  var authorizationHeader = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer sk_test_03e1b8633a6266c14cc23bfba60dca244bda02a4',
    'Accept': 'application/json'
  };

  @override
  Future<void> addCardDetails(
      {required cardDetails,
      required String email,
      required BuildContext context}) async {
    var encodeToJson = jsonEncode(cardDetails);

    showLoaderDialog(context);

    try {
      final uri = Uri.https(cxHead, '/payment/card/details/add/$email',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        throw TimeoutException(errorMessage);
      });

      Navigator.pop(context);
      if (_response.statusCode == 200) {
        context.read<NavDrawerCubit>().getCards();
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'New credit card added to your account');
        debugPrint('New credit card added to your account');
      } else if (_response.statusCode == 409) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Card already exits');
        debugPrint('Card already exits');
      }
    } catch (_) {
      Navigator.pop(context);
      debugPrint('An error occurred');
    }
  }

  @override
  Future<List<BankInfoModel>> getNigerianBanks() async {
    late Response _response;

    List<BankInfoModel> bankList = [];
    try {
      final uri = Uri.https(payStackEndpoint, '/bank');
      _response = await client
          .get(uri, headers: authorizationHeader)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        var errorMessage = 'The connection has timed out, Please try again';
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        var jsonBody = json.decode(_response.body);
        var body = jsonBody['data'];

        for (var item in body) {
          bankList.add(BankInfoModel(
              bankName: item['name'],
              bankCode: item['code'],
              accountNumber: '',
              accountName: ''));
        }
        debugPrint('List of Nigerian banks fetched');
        return bankList;
      } else {
        debugPrint('Unable to fetch Nigerian banks');
        return bankList;
      }
    } catch (error) {
      debugPrint('Error in fetching Nigerian banks \n $error');
      return bankList;
    }
  }

  @override
  Future<BankInfoModel> verifyAccountNumber(
      {required String accountNumber,
      required bankName,
      required bankCode,
      required BuildContext context}) async {
    showLoaderDialog(context);

    try {
      final uri = Uri.https(payStackEndpoint, '/bank/resolve',
          {'account_number': accountNumber, 'bank_code': bankCode});
      _response = await client
          .get(uri, headers: authorizationHeader)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        var errorMessage = 'The connection has timed out, Please try again';
        throw TimeoutException(errorMessage);
      });

      Navigator.pop(context);
      if (_response.statusCode == 200) {
        Navigator.pop(context);

        var body = jsonDecode(_response.body);
        filterText.value = '';
        debugPrint('Bank details fetched');
        return BankInfoModel(
            bankName: bankName,
            bankCode: bankCode,
            accountNumber: body['data']['account_number'],
            accountName: body['data']['account_name']);
      } else {
        debugPrint('Unable to fetch bank details');
        return BankInfoModel(
            bankName: '',
            bankCode: bankCode,
            accountNumber: accountNumber,
            accountName: '');
      }
    } catch (error) {
      debugPrint('Error in fetching bank details $error');
      return BankInfoModel(
          bankName: '',
          bankCode: bankCode,
          accountNumber: accountNumber,
          accountName: '');
    }
  }

  @override
  Future<void> addBank(
      {required bankDetails,
      required String email,
      required BuildContext context}) async {
    showLoaderDialog(context);

    var encodeToJson = jsonEncode(bankDetails);

    try {
      final uri = Uri.https(cxHead, '/payment/bank/details/add/$email',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        throw TimeoutException(errorMessage);
      });
      Navigator.pop(context);
      if (_response.statusCode == 200) {
        context.read<NavDrawerCubit>().getBankAccounts();
        Fluttertoast.showToast(msg: 'Bank details added');
        Navigator.pop(context);
        context.read<PaymentCubit>().resetState();
        debugPrint('Bank details added');
      } else if (_response.statusCode == 409) {
        Fluttertoast.showToast(msg: 'Bank details added');
        debugPrint('Account already exits');
      }
    } catch (_) {
      debugPrint('Error adding bank details \n $_');
    }
  }
}
