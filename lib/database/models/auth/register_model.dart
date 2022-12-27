class RegisterModel {
  RegisterModel({
    this.email,
    this.password,
    this.username,
    this.phoneNumber,
    this.isVendor,
  });

  RegisterModel.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    username = json['profile_name'];
    phoneNumber = json['phone_number'];
    isVendor = json['is_vendor'];
  }
  String? email;
  String? password;
  String? username;
  String? phoneNumber;
  bool? isVendor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['profile_name'] = username;
    map['phone_number'] = phoneNumber;
    map['is_vendor'] = isVendor;
    return map;
  }
}
