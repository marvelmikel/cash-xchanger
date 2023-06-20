class ResetModel {
  ResetModel({
    this.email,
    this.password,
    this.otp,
  });

  ResetModel.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
  }
  String? email;
  String? password;
  String? otp;
  ResetModel copyWith({
    String? email,
    String? password,
    String? otp,
  }) =>
      ResetModel(
        email: email ?? this.email,
        password: password ?? this.password,
        otp: otp ?? this.otp,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['otp'] = otp;
    return map;
  }
}
