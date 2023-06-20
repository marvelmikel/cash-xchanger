import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempStorage {
  TempStorage._();

  static final TempStorage _instance = TempStorage._();
  static TempStorage get instance => _instance;
  late SharedPreferences sharedPreferences;

  Future<void> init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  Future<void> saveUserData({required User userData}) async {
    await sharedPreferences.setString('USER', json.encode(userData.toJson()));
    debugPrint('Profile data saved');
  }

  User? getUserData() {
    final data = sharedPreferences.getString('USER');
    if (data != null) {
      return User.fromJson(json.decode(data));
    } else {
      return null;
    }
  }

  Future<void> saveUserImage({required String userImage}) async {
    await sharedPreferences.setString('USER_IMAGE', userImage);
    debugPrint('Image data saved');
  }

  String getUserImage() {
    return sharedPreferences.getString('USER_IMAGE') ?? '';
  }

  Future<void> saveUnfinishedTransaction({required String transaction}) async {
    await sharedPreferences.setString('UNFINISHED_TRANSACTION', transaction);
    debugPrint('Transaction data saved');
  }

  String getUnfinishedTransaction() {
    return sharedPreferences.getString('UNFINISHED_TRANSACTION') ?? '';
  }

  void removeUnfinishedTransaction() async {
    await sharedPreferences.remove('UNFINISHED_TRANSACTION');
    debugPrint('Unfinished Transaction cleared');
  }

  Future<void> saveUnfinishedCashOrder({required String transaction}) async {
    await sharedPreferences.setString('UNFINISHED_ORDER', transaction);
    debugPrint('Transaction data saved');
  }

  String getUnfinishedCashOrder() {
    return sharedPreferences.getString('UNFINISHED_ORDER') ?? '';
  }

  void removeUnfinishedCashOrder() async {
    await sharedPreferences.remove('UNFINISHED_ORDER');
    debugPrint('Unfinished Order cleared');
  }

  Future<void> saveUserBalance({required String userBalance}) async {
    await sharedPreferences.setString('USER_BALANCE', userBalance);
    debugPrint('Balance data saved');
  }

  Future<void> saveAuthToken({required String authToken}) async {
    await sharedPreferences.setString('TOKEN', authToken);
    debugPrint('User token saved $authToken');
  }

  String getUserBalance() {
    return sharedPreferences.getString('USER_BALANCE') ?? '';
  }

  void resetData() async {
    await sharedPreferences.clear();

    debugPrint('User data cleared');
  }

  String getVendorRating() {
    return sharedPreferences.getString('VENDOR_RATING') ?? '';
  }

  Future<void> saveVendorRating({required String vendorRating}) async {
    await sharedPreferences.setString('VENDOR_RATING', vendorRating);
    debugPrint('Vendor rating saved');
  }

  Future<void> confirmedCashBooking() async {
    await sharedPreferences.setBool('CONFIRM', false);
    debugPrint('Cash booking confirmed');
  }

  void resetConfirmedCashBooking() async {
    await sharedPreferences.remove('CONFIRM');
  }

  bool getCashBooking() {
    return sharedPreferences.getBool('CONFIRM') ?? false;
  }

  String getAuthToken() {
    return sharedPreferences.getString('TOKEN') ?? '';
  }

  String getFCMToken() {
    return sharedPreferences.getString('FCM_TOKEN') ?? '';
  }

  Future<void> saveFCMToken({required String authToken}) async {
    await sharedPreferences.setString('FCM_TOKEN', authToken);
    debugPrint('Balance data saved');
  }

  Future<void> deleteToken() async {
    await sharedPreferences.remove('AUTH_TOKEN');
  }
}
