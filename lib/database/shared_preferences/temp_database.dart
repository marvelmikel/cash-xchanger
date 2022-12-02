import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TempDataBaseService {
  Future<void> saveUserData({required String userData});

  Future<void> saveUserImage({required String userImage});

  Future<void> saveUserBalance({required String userBalance});

  Future<void> saveVendorRating({required String vendorRating});

  Future<void> saveUnfinishedTransaction({required String transaction});

  Future<void> saveUnfinishedCashOrder({required String transaction});

  Future<void> confirmedCashBooking();

  String getUserData();

  String getUserImage();

  String getUserBalance();

  String getVendorRating();

  bool getCashBooking();

  String getUnfinishedTransaction();

  String getUnfinishedCashOrder();

  void resetData();

  void resetConfirmedCashBooking();

  void removeUnfinishedCashOrder();

  void removeUnfinishedTransaction();
}

class TempDataBaseImpl extends TempDataBaseService {
  SharedPreferences sharedPreferences;

  TempDataBaseImpl({required this.sharedPreferences});

  @override
  Future<void> saveUserData({required String userData}) async {
    await sharedPreferences.setString('USER_DATA', userData);
    debugPrint('Profile data saved');
  }

  @override
  String getUserData() {
    return sharedPreferences.getString('USER_DATA') ?? '';
  }

  @override
  Future<void> saveUserImage({required String userImage}) async {
    await sharedPreferences.setString('USER_IMAGE', userImage);
    debugPrint('Image data saved');
  }

  @override
  String getUserImage() {
    return sharedPreferences.getString('USER_IMAGE') ?? '';
  }

  @override
  Future<void> saveUnfinishedTransaction({required String transaction}) async {
    await sharedPreferences.setString('UNFINISHED_TRANSACTION', transaction);
    debugPrint('Transaction data saved');
  }

  @override
  String getUnfinishedTransaction() {
    return sharedPreferences.getString('UNFINISHED_TRANSACTION') ?? '';
  }

  @override
  void removeUnfinishedTransaction() async {
    await sharedPreferences.remove('UNFINISHED_TRANSACTION');
    debugPrint('Unfinished Transaction cleared');
  }

  @override
  Future<void> saveUnfinishedCashOrder({required String transaction}) async {
    await sharedPreferences.setString('UNFINISHED_ORDER', transaction);
    debugPrint('Transaction data saved');
  }

  @override
  String getUnfinishedCashOrder() {
    return sharedPreferences.getString('UNFINISHED_ORDER') ?? '';
  }

  @override
  void removeUnfinishedCashOrder() async {
    await sharedPreferences.remove('UNFINISHED_ORDER');
    debugPrint('Unfinished Order cleared');
  }

  @override
  Future<void> saveUserBalance({required String userBalance}) async {
    await sharedPreferences.setString('USER_BALANCE', userBalance);
    debugPrint('Balance data saved');
  }

  @override
  String getUserBalance() {
    return sharedPreferences.getString('USER_BALANCE') ?? '';
  }

  @override
  void resetData() async {
    await sharedPreferences.remove('USER_BALANCE');
    await sharedPreferences.remove('USER_DATA');
    await sharedPreferences.remove('USER_IMAGE');
    await sharedPreferences.remove('UNFINISHED_TRANSACTION');
    await sharedPreferences.remove('VENDOR_RATING');
    debugPrint('User data cleared');
  }

  @override
  String getVendorRating() {
    return sharedPreferences.getString('VENDOR_RATING') ?? '';
  }

  @override
  Future<void> saveVendorRating({required String vendorRating}) async {
    await sharedPreferences.setString('VENDOR_RATING', vendorRating);
    debugPrint('Vendor rating saved');
  }

  @override
  Future<void> confirmedCashBooking() async {
    await sharedPreferences.setBool('CONFIRM', false);
    debugPrint('Cash booking confirmed');
  }

  @override
  void resetConfirmedCashBooking() async {
    await sharedPreferences.remove('CONFIRM');
  }

  @override
  bool getCashBooking() {
    return sharedPreferences.getBool('CONFIRM') ?? false;
  }
}
