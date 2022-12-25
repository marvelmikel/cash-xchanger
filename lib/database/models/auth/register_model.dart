class RegisterModel {
  RegisterModel({
      this.email,
      this.password,
      this.firstName,
      this.username,
      this.lastName,
      this.phoneNumber,
      this.isVendor,});

  RegisterModel.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    phoneNumber = json['phone_number'];
    isVendor = json['is_vendor'];
  }
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? username;
  String? phoneNumber;
  bool? isVendor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['username'] = username;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['phone_number'] = phoneNumber;
    map['is_vendor'] = isVendor;
    return map;
  }

}