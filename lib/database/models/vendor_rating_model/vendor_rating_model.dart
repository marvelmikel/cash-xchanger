// To parse this JSON data, do
//
//     final vendorRatings = vendorRatingsFromMap(jsonString);

import 'dart:convert';

VendorRatingsModel vendorRatingsFromMap(String str) =>
    VendorRatingsModel.fromMap(json.decode(str));

String vendorRatingsModelToMap(VendorRatingsModel data) =>
    json.encode(data.toMap());

class VendorRatingsModel {
  VendorRatingsModel({
    required this.averageRating,
    required this.percentageCompletion,
    required this.percentageRejected,
    required this.vendorName,
  });

  double averageRating;
  double percentageCompletion;
  double percentageRejected;
  String vendorName;

  factory VendorRatingsModel.fromMap(Map<String, dynamic> json) =>
      VendorRatingsModel(
        averageRating: json['average_rating'].toDouble(),
        percentageCompletion: json['percentage_completion'].toDouble(),
        percentageRejected: json['percentage_rejected'],
        vendorName: json['vendor_name'],
      );

  Map<String, dynamic> toMap() => {
        'average_rating': averageRating,
        'percentage_completion': percentageCompletion,
        'percentage_rejected': percentageRejected,
        'vendor_name': vendorName,
      };
}
