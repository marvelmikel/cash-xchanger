// To parse this JSON data, do
//
//     final transactionBalanceModel = transactionBalanceModelFromMap(jsonString);

import 'dart:convert';

TransactionBalanceModel transactionBalanceModelFromMap(String str) =>
    TransactionBalanceModel.fromMap(json.decode(str));

String transactionBalanceModelToMap(TransactionBalanceModel data) =>
    json.encode(data.toMap());

class TransactionBalanceModel {
  TransactionBalanceModel({
    required this.userBalance,
    required this.userName,
  });

  String userBalance;
  String userName;

  factory TransactionBalanceModel.fromMap(Map<String, dynamic> json) =>
      TransactionBalanceModel(
        userBalance: json['user_balance'] ?? '',
        userName: json['user_name'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'user_balance': userBalance,
        'user_name': userName,
      };
}
