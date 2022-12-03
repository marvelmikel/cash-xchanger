// To parse this JSON data, do
//
//     final tempCashModel = tempCashModelFromMap(jsonString);

import 'dart:convert';

TempCashModel tempCashModelFromMap(String str) =>
    TempCashModel.fromMap(json.decode(str));

String tempCashModelToMap(TempCashModel data) => json.encode(data.toMap());

class TempCashModel {
  TempCashModel({
    required this.nearestVendors,
  });

  NearestVendors nearestVendors;

  factory TempCashModel.fromMap(Map<String, dynamic> json) => TempCashModel(
        nearestVendors: NearestVendors.fromMap(json['nearest vendors']),
      );

  Map<String, dynamic> toMap() => {
        'nearest vendors': nearestVendors.toMap(),
      };
}

class NearestVendors {
  NearestVendors({
    required this.cashAvailable,
    required this.cashSummary,
    required this.meetupLocation,
    required this.phoneNumber,
    required this.profileImage,
    required this.transactionRef,
    required this.vendorId,
    required this.vendorLat,
    required this.vendorLong,
    required this.vendorName,
    required this.vendorUserDist,
  });

  String cashAvailable;
  CashSummary cashSummary;
  String meetupLocation;
  String phoneNumber;
  String profileImage;
  String transactionRef;
  String vendorId;
  String vendorLat;
  String vendorLong;
  String vendorName;
  double vendorUserDist;

  factory NearestVendors.fromMap(Map<String, dynamic> json) => NearestVendors(
        cashAvailable: json['cash_available'],
        cashSummary: CashSummary.fromMap(json['cash_summary']),
        meetupLocation: json['meetup_location'],
        phoneNumber: json['phone_number'],
        profileImage: json['profile_image'],
        transactionRef: json['transaction_ref'],
        vendorId: json['vendor_id'],
        vendorLat: json['vendor_lat'],
        vendorLong: json['vendor_long'],
        vendorName: json['vendor_name'],
        vendorUserDist: json['vendor_user_dist'],
      );

  Map<String, dynamic> toMap() => {
        'cash_available': cashAvailable,
        'cash_summary': cashSummary.toMap(),
        'meetup_location': meetupLocation,
        'phone_number': phoneNumber,
        'profile_image': profileImage,
        'transaction_ref': transactionRef,
        'vendor_id': vendorId,
        'vendor_lat': vendorLat,
        'vendor_long': vendorLong,
        'vendor_name': vendorName,
        'vendor_user_dist': vendorUserDist,
      };
}

class CashSummary {
  CashSummary({
    required this.cashAmount,
    required this.cashType,
    required this.denominations,
  });

  double cashAmount;
  String cashType;
  Denominations denominations;

  factory CashSummary.fromMap(Map<String, dynamic> json) => CashSummary(
        cashAmount: json['cash_amount'],
        cashType: json['cash_type'],
        denominations: Denominations.fromMap(json['denominations']),
      );

  Map<String, dynamic> toMap() => {
        'cash_amount': cashAmount,
        'cash_type': cashType,
        'denominations': denominations.toMap(),
      };
}

class Denominations {
  Denominations({
    required this.fifty,
    required this.fiveHundred,
    required this.hundred,
    required this.oneThousand,
    required this.twoHundred,
  });

  int fifty;
  int fiveHundred;
  int hundred;
  int oneThousand;
  int twoHundred;

  factory Denominations.fromMap(Map<String, dynamic> json) => Denominations(
        fifty: json['fifty'],
        fiveHundred: json['five_hundred'],
        hundred: json['hundred'],
        oneThousand: json['one_thousand'],
        twoHundred: json['two_hundred'],
      );

  Map<String, dynamic> toMap() => {
        'fifty': fifty,
        'five_hundred': fiveHundred,
        'hundred': hundred,
        'one_thousand': oneThousand,
        'two_hundred': twoHundred,
      };
}
