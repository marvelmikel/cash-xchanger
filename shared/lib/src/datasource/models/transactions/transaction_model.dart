class TransactionCharges {
  TransactionCharges({
    this.amount,
    this.fee,
    this.total,});

  TransactionCharges.fromJson(dynamic json) {
    amount = json['amount'];
    fee = json['fee'];
    total = json['total'];
  }
  double? amount;
  double? fee;
  double? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['fee'] = fee;
    map['total'] = total;
    return map;
  }

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
