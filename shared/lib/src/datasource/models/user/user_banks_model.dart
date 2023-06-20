class BanksRes {
  BanksRes({
    required this.bankDetails,
  });

  List<Banks> bankDetails;

  factory BanksRes.fromMap(Map<String, dynamic> json) => BanksRes(
        bankDetails:
            List<Banks>.from(json['bank_details'].map((x) => Banks.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'bank_details': List<dynamic>.from(bankDetails.map((x) => x.toMap())),
      };
}

class Banks {
  Banks({
    required this.accountName,
    required this.bank,
    required this.bankAccountNo,
    required this.id,
  });

  String accountName;
  String bank;
  String bankAccountNo;
  int id;

  factory Banks.fromMap(Map<String, dynamic> json) => Banks(
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


class BankInfoModel {
  String bankName;
  String bankCode;
  String accountNumber;
  String accountName;

  BankInfoModel({
    required this.bankName,
    required this.bankCode,
    required this.accountNumber,
    required this.accountName,
  });
}
