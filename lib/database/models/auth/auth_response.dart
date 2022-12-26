

class AuthReqResponse {
  AuthReqResponse({
      this.authResponse, 
      this.message, 
      this.statusCode,});

  AuthReqResponse.fromJson(dynamic json) {
    authResponse = json['data'] != null ? AuthResponse.fromJson(json['data']) : null;
    message = json['message'];
    statusCode = json['statusCode'];
  }
  AuthResponse? authResponse;
  String? message;
  int? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (authResponse != null) {
      map['data'] = authResponse!.toJson();
    }
    map['message'] = message;
    map['statusCode'] = statusCode;
    return map;
  }

}

class AuthResponse {
  AuthResponse({
    this.status,});

  AuthResponse.fromJson(dynamic json) {
    status = json['status'];
  }
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    return map;
  }

}