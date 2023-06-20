class Cards {
  Cards({
    required this.cardName,
    required this.cardBin,
    required this.cardNumber,
    required this.cvv,
    required this.expiry,
    required this.id,
    required this.isDefault,
  });

  String cardName;
  String cardBin;
  String cardNumber;
  String cvv;
  String expiry;
  int id;
  bool isDefault;

  ///Id
  //         cardBin
  //         cardType
  //         countryCode
  //         expMonth
  //         expYear
  //         firstName
  //         isDefault
  //         last4
  //         lastName

  factory Cards.fromMap(Map<String, dynamic> json) => Cards(
    cardName: json['card_name'] ?? '',
    cardNumber: json['card_number'] ?? '',
    cvv: json['cvv'] ?? '',
    expiry: json['expiry'] ?? '',
    id: json['id'] ?? '',
    cardBin: json['cardBin'] ?? '',
    isDefault: json['isDefault'] ?? false,
  );

  Map<String, dynamic> toMap() => {
    'card_name': cardName,
    'card_number': cardNumber,
    'cvv': cvv,
    'expiry': expiry,
    'id': id,
    'isDefault': isDefault,
    'cardBin': cardBin,
  };
}