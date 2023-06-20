
import 'package:shared/shared.dart';
import 'package:user/user.dart';

import '../user/user_model.dart';

class LoginCall {
  Response? response;

  LoginCall({this.response});

  LoginCall.fromJson(Map<String, dynamic> json) {
    response = json['data'] != null ? Response.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['data'] = response!.toJson();
    }
    return data;
  }
}

class Response {
  AuthCollection? authCollection;
  UserCollection? userCollection;
  CardCollection? cardCollection;

  Response({this.authCollection, this.userCollection, this.cardCollection});

  Response.fromJson(Map<String, dynamic> json) {
    authCollection = json['AuthCollection'] != null
        ? AuthCollection.fromJson(json['AuthCollection'])
        : null;
    userCollection = json['UserCollection'] != null
        ? UserCollection.fromJson(json['UserCollection'])
        : null;

    cardCollection = json['CardCollection'] != null
        ? CardCollection.fromJson(json['CardCollection'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (authCollection != null) {
      data['AuthCollection'] = authCollection!.toJson();
    }
    if (userCollection != null) {
      data['UserCollection'] = userCollection!.toJson();
    }
    if (cardCollection != null) {
      data['CardCollection'] = cardCollection!.toJson();
    }
    return data;
  }
}

class AuthCollection {
  UserLogin? userLogin;

  AuthCollection({this.userLogin});

  AuthCollection.fromJson(Map<String, dynamic> json) {
    userLogin = json['userLogin'] != null
        ? UserLogin.fromJson(json['userLogin'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userLogin != null) {
      data['userLogin'] = userLogin!.toJson();
    }
    return data;
  }
}

class UserLogin {
  String? id;
  String? device;
  String? loginAt;
  String? token;
  String? userId;
  User? user;

  UserLogin(
      {this.id, this.device, this.loginAt, this.token, this.userId, this.user});

  UserLogin.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    device = json['device'];
    loginAt = json['loginAt'];
    token = json['token'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['device'] = device;
    data['loginAt'] = loginAt;
    data['token'] = token;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class SignUpCall {
  UserCollection? userCollection;

  SignUpCall({this.userCollection});

  SignUpCall.fromJson(Map<String, dynamic> json) {
    userCollection = json['UserCollection'] != null
        ? UserCollection.fromJson(json['UserCollection'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userCollection != null) {
      data['UserCollection'] = userCollection!.toJson();
    }
    return data;
  }
}

class UserCollection {
  UserLogin? userLogin;
  String? createUser;
  User? user;
  TransactionCharges? fees;
  UserCollection({this.userLogin, this.createUser, this.fees});

  UserCollection.fromJson(Map<String, dynamic> json) {
    userLogin = json['verifyPhoneNumber'] != null
        ? UserLogin.fromJson(json['verifyPhoneNumber'])
        : null;
    createUser = json['createUser'];
    fees = json['getFee'] != null
        ? TransactionCharges.fromJson(json['getFee'])
        : null;
    user = json['setAvaliableCashByVendor'] != null
        ? User.fromJson(json['setAvaliableCashByVendor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userLogin != null) {
      data['verifyPhoneNumber'] = userLogin!.toJson();
    }
    if (fees != null) {
      data['getFee'] = fees!.toJson();
    }
    if (user != null) {
      data['setAvaliableCashByVendor'] = user!.toJson();
    }
    data['createUser'] = createUser;
    return data;
  }
}

class CardCollection {
  CardAuthorization? cardAuth;

  CardCollection({this.cardAuth});

  CardCollection.fromJson(Map<String, dynamic> json) {
    cardAuth = json['initiate'] != null
        ? CardAuthorization.fromJson(json['initiate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cardAuth != null) {
      data['initiate'] = cardAuth!.toJson();
    }
    return data;
  }
}
