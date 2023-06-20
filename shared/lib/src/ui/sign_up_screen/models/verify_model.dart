class VerifyModel {
  VerifyModel({this.phoneNumber, this.code});

  VerifyModel.fromJson(dynamic json) {
    phoneNumber = json['phoneNumber'];
    if (json['code'] != null) {
      code = json['code'];
    }
  }
  String? code;
  String? phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = phoneNumber;
    if (code != null) {
      map['code'] = code;
    }

    return map;
  }
}
