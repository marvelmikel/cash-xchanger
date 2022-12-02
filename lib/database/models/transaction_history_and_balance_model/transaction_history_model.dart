// To parse this JSON data, do
//
//     final transactionBalanceModel = transactionBalanceModelFromMap(jsonString);

import 'dart:convert';

TransactionHistoryModel transactionHistoryModelFromMap(String str) =>
    TransactionHistoryModel.fromMap(json.decode(str));

String transactionHistoryModelToMap(TransactionHistoryModel data) =>
    json.encode(data.toMap());


class TransactionHistoryModel {
  TransactionHistoryModel({
    required this.transactionHistory,
  });

  List<TransactionHistory> transactionHistory;

  factory TransactionHistoryModel.fromMap(Map<String, dynamic> json) =>
      TransactionHistoryModel(
        transactionHistory: List<TransactionHistory>.from(
            json['transaction_history']
                .map((x) => TransactionHistory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'transaction_history':
            List<dynamic>.from(transactionHistory.map((x) => x.toMap())),
      };
}

class TransactionHistory {
  TransactionHistory({
    required this.amount,
    required this.cashSummary,
    required this.cashType,
    required this.dateCreated,
    required this.dateVerified,
    required this.id,
    required this.receiverId,
    required this.reference,
    required this.remarks,
    required this.senderId,
    required this.status,
    required this.type,
  });

  String amount;
  String cashSummary;
  String cashType;
  String dateCreated;
  String dateVerified;
  int id;
  String receiverId;
  String reference;
  String remarks;
  String senderId;
  String status;
  String type;

  factory TransactionHistory.fromMap(Map<String, dynamic> json) =>
      TransactionHistory(
        amount: json['amount'] ?? '',
        cashSummary: json['cash_summary'] ?? '',
        cashType: json['cash_type'] ?? '',
        dateCreated: json['date_created'] ?? '',
        dateVerified: json['date_verified'] ?? '',
        id: json['id'],
        receiverId: json['receiver_id'] ?? '',
        reference: json['reference'] ?? '',
        remarks: json['remarks'] ?? '',
        senderId: json['sender_id'] ?? '',
        status: json['status'] ?? '',
        type: json['type'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'amount': amount,
        'cash_summary': cashSummary,
        'cash_type': cashType,
        'date_created': dateCreated,
        'date_verified': dateVerified,
        'id': id,
        'receiver_id': receiverId,
        'reference': reference,
        'remarks': remarks,
        'sender_id': senderId,
        'status': status,
        'type': type,
      };
}
