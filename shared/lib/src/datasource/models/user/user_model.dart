import 'package:shared/src/datasource/models/user/user_cards_model.dart';

class User {
  String? id;
  List<Cards>? cards;
  String? city;
  String? email;
  String? fullName;
  double? avaliableCash;
  double? totalDepensedCashed;
  String? generatedJobId;
  bool? isActive;
  bool? isDeleted;
  bool? isEmailVerified;
  bool? isKycVerified;
  bool? isPhoneNumberVerified;
  bool? isVendor;
  String? jobId;
  String? kycDocument;
  String? kycReceipt;
  String? kycSelfie;
  String? phoneNumber;
  String? role;
  String? selfie;
  String? signature;

  User(
      {this.id,
      this.cards,
      this.city,
      this.email,
      this.fullName,
      this.generatedJobId,
      this.isActive,
      this.isDeleted,
      this.isEmailVerified,
      this.isKycVerified,
      this.isPhoneNumberVerified,
      this.isVendor,
      this.jobId,
      this.kycDocument,
      this.kycReceipt,
      this.kycSelfie,
        this.avaliableCash,
        this.totalDepensedCashed,
      this.phoneNumber,
      this.role,
      this.selfie,
      this.signature});

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(Cards.fromMap(v));
      });
    }
    city = json['city'];
    email = json['email'];
    fullName = json['fullName'];
    generatedJobId = json['generatedJobId'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    isEmailVerified = json['isEmailVerified'];
    isKycVerified = json['isKycVerified'];
    isPhoneNumberVerified = json['isPhoneNumberVerified'];
    isVendor = json['isVendor'];
    jobId = json['jobId'];
    avaliableCash = json['avaliableCash'];
    totalDepensedCashed = json['totalDepensedCashed'];
    kycDocument = json['kycDocument'];
    kycReceipt = json['kycReceipt'];
    kycSelfie = json['kycSelfie'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    selfie = json['selfie'];
    signature = json['signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    if (cards != null) {
      data['cards'] = cards!.map((v) => v.toMap()).toList();
    }
    data['city'] = city;
    data['email'] = email;
    data['fullName'] = fullName;
    data['generatedJobId'] = generatedJobId;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    data['isEmailVerified'] = isEmailVerified;
    data['isKycVerified'] = isKycVerified;
    data['isPhoneNumberVerified'] = isPhoneNumberVerified;
    data['isVendor'] = isVendor;
    data['jobId'] = jobId;
    data['kycDocument'] = kycDocument;
    data['avaliableCash'] = avaliableCash;
    data['totalDepensedCashed'] = totalDepensedCashed;
    data['kycReceipt'] = kycReceipt;
    data['kycSelfie'] = kycSelfie;
    data['phoneNumber'] = phoneNumber;
    data['role'] = role;
    data['selfie'] = selfie;
    data['signature'] = signature;
    return data;
  }
}
