// To parse this JSON data, do
//
//     final usersModel = usersModelFromMap(jsonString);

import 'dart:convert';

CardModel cardModelFromMap(String str) => CardModel.fromMap(json.decode(str));

String cardModelToMap(CardModel data) => json.encode(data.toMap());

class CardModel {
  CardModel({required this.cardDetails});

  List<CardDetail> cardDetails;

  factory CardModel.fromMap(Map<String, dynamic> json) => CardModel(
        cardDetails: List<CardDetail>.from(
            json['card_details'].map((x) => CardDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'card_details': List<dynamic>.from(cardDetails.map((x) => x.toMap())),
      };
}

class CardDetail {
  CardDetail({
    required this.cardName,
    required this.cardNumber,
    required this.cvv,
    required this.expiry,
    required this.id,
  });

  String cardName;
  String cardNumber;
  String cvv;
  String expiry;
  int id;

  factory CardDetail.fromMap(Map<String, dynamic> json) => CardDetail(
        cardName: json['card_name'] ?? '',
        cardNumber: json['card_number'] ?? '',
        cvv: json['cvv'] ?? '',
        expiry: json['expiry'] ?? '',
        id: json['id'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'card_name': cardName,
        'card_number': cardNumber,
        'cvv': cvv,
        'expiry': expiry,
        'id': id,
      };
}
