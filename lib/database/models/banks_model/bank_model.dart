// To parse this JSON data, do
//
//     final bankModel = bankModelFromMap(jsonString);

import 'dart:convert';

BankModel bankModelFromMap(String str) => BankModel.fromMap(json.decode(str));

String bankModelToMap(BankModel data) => json.encode(data.toMap());

class BankModel {
  BankModel({
    required this.bankDetails,
  });

  List<BankDetail> bankDetails;

  factory BankModel.fromMap(Map<String, dynamic> json) => BankModel(
        bankDetails: List<BankDetail>.from(
            json['bank_details'].map((x) => BankDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'bank_details': List<dynamic>.from(bankDetails.map((x) => x.toMap())),
      };
}

class BankDetail {
  BankDetail({
    required this.accountName,
    required this.bank,
    required this.bankAccountNo,
    required this.id,
  });

  String accountName;
  String bank;
  String bankAccountNo;
  int id;

  factory BankDetail.fromMap(Map<String, dynamic> json) => BankDetail(
        accountName: json['account_name'] ?? '',
        bank: json['bank'] ?? '',
        bankAccountNo: json['bank_account_no'] ?? '',
        id: json['id'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'account_name': accountName,
        'bank': bank,
        'bank_account_no': bankAccountNo,
        'id': id,
      };
}
