class VerifyModel {
  VerifyModel({
    this.email,
    this.otp,
  });

  VerifyModel.fromJson(dynamic json) {
    email = json['email'];
    otp = json['otp'];
  }
  String? email;
  String? otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['otp'] = otp;
    return map;
  }
}
