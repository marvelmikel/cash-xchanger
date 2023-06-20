class RegisterModel {
  String? email;
  String? fullName;
  String? phoneNumber;
  String? credentials;
  String? city;
  bool? isVendor;

  RegisterModel(
      {this.email,
        this.fullName,
        this.phoneNumber,
        this.credentials,
        this.city,
        this.isVendor});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    credentials = json['credentials'];
    city = json['city'];
    isVendor = json['isVendor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['credentials'] = credentials;
    data['city'] = city;
    data['isVendor'] = isVendor;
    return data;
  }
}
