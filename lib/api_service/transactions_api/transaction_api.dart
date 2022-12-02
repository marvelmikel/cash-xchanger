import 'dart:async';

import 'package:cash_xchanger/database/models/transaction_history_and_balance_model/transaction_balance_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../database/models/transaction_history_and_balance_model/transaction_history_model.dart';
import '../../database/shared_preferences/temp_database.dart';
import '../service.dart';

abstract class TransactionHistoryService {
  Future<List<TransactionHistory>> transactionsHistory(
      {required String email, required BuildContext context});
}

class TransactionHistoryImp extends TransactionHistoryService {
  late Response _response;
  TempDataBaseImpl tempDataBaseImpl;

  TransactionHistoryImp({required this.tempDataBaseImpl});

  @override
  Future<List<TransactionHistory>> transactionsHistory(
      {required String email, required BuildContext context}) async {
    try {
      final uri = Uri.https(cxHead, '/dashboard/$email',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});
      _response = await client
          .get(uri, headers: header)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        var balanceModel = transactionBalanceModelFromMap(_response.body);
        tempDataBaseImpl.saveUserBalance(
            userBalance: transactionBalanceModelToMap(balanceModel));
        debugPrint('Fetched history and balance');
        return transactionHistoryModelFromMap(_response.body)
            .transactionHistory;
      }
    } catch (_) {
      debugPrint('Error fetching history and balance: \n$_');
      return [];
    }
    return [];
  }
}
