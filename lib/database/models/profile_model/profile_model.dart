import 'dart:convert';

ProfileModel profileModelFromMap(String str) =>
    ProfileModel.fromMap(json.decode(str));

String profileModelToMap(ProfileModel data) => json.encode(data.toMap());

class ProfileModel {
  ProfileModel({
    required this.userBalance,
    required this.userDetails,
  });

  String userBalance;
  UserDetails userDetails;

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        userBalance: json['user_balance'],
        userDetails: UserDetails.fromMap(json['user_details']),
      );

  Map<String, dynamic> toMap() => {
        'user_balance': userBalance,
        'user_details': userDetails.toMap(),
      };
}

class UserDetails {
  UserDetails({
    required this.email,
    required this.firstName,
    required this.id,
    required this.isDocumentVerified,
    required this.isPinSet,
    required this.isVerified,
    required this.lastName,
    required this.phoneNumber,
    required this.userRole,
    required this.username,
  });

  String email;
  String firstName;
  int id;
  bool isDocumentVerified;
  bool isPinSet;
  bool isVerified;
  String lastName;
  String phoneNumber;

  String userRole;
  String username;

  factory UserDetails.fromMap(Map<String, dynamic> json) => UserDetails(
        email: json['email'] ?? '',
        firstName: json['first_name'] ?? '',
        id: json['id'] ?? '',
        isDocumentVerified: json['is_document_verified'] ?? '',
        isPinSet: json['is_pin_set'] ?? '',
        isVerified: json['is_verified'] ?? '',
        lastName: json['last_name'] ?? '',
        phoneNumber: json['phone_number'] ?? '',
        userRole: json['user_role'] ?? '',
        username: json['profile_name'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'first_name': firstName,
        'id': id,
        'is_document_verified': isDocumentVerified,
        'is_pin_set': isPinSet,
        'is_verified': isVerified,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'user_role': userRole,
        'profile_name': username,
      };
}

ProfilePic profilePicFromMap(String str) =>
    ProfilePic.fromMap(json.decode(str));

String profilePicToMap(ProfilePic data) => json.encode(data.toMap());

class ProfilePic {
  ProfilePic({
    required this.userBalance,
    required this.userDetails,
  });

  String userBalance;
  ProfilePicDetails userDetails;

  factory ProfilePic.fromMap(Map<String, dynamic> json) => ProfilePic(
        userBalance: json['user_balance'] ?? '',
        userDetails: ProfilePicDetails.fromMap(json['user_details'] ?? ''),
      );

  Map<String, dynamic> toMap() => {
        'user_balance': userBalance,
        'user_details': userDetails.toMap(),
      };
}

class ProfilePicDetails {
  ProfilePicDetails({
    required this.profilePic,
  });

  String profilePic;

  factory ProfilePicDetails.fromMap(Map<String, dynamic> json) =>
      ProfilePicDetails(
        profilePic: json['profile_pic'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'profile_pic': profilePic,
      };
}
