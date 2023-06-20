class LoginModel {
  LoginModel({
    this.username,
    this.credentials,
  });

  LoginModel.fromJson(dynamic json) {
    username = json['username'];
    credentials = json['credentials'];
  }
  String? username;
  String? credentials;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['credentials'] = credentials;
    return map;
  }
}
