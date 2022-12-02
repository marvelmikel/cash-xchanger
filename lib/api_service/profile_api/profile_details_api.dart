import 'dart:async';
import 'dart:convert';

import 'package:cash_xchanger/database/models/profile_model/profile_model.dart';
import 'package:cash_xchanger/database/models/vendor_rating_model/vendor_rating_model.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/ui/vendor/upload_doc/upload_id.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../database/shared_preferences/temp_database.dart';
import '../../ui/vendor/upload_doc/upload_photo_bottomsheet.dart';
import '../service.dart';

abstract class ProfileDetailsService {
  Future<bool> profileDetails(
      {required String email, required BuildContext context});

  Future<void> uploadImage(
      {required String imageBytes,
      required BuildContext context,
      required email});

  Future<void> changePassword(
      {required previousPassword,
      required newPassword,
      required email,
      required BuildContext context});

  Future<void> vendorRating({required BuildContext context, required email});

  Future<void> uploadID(
      {required String email,
      required String imagePath,
      required BuildContext context});
}

class ProfileDetailsImp extends ProfileDetailsService {
  static late Response _response;
  TempDataBaseImpl tempDataBaseImpl;

  ProfileDetailsImp({required this.tempDataBaseImpl});

  @override
  Future<bool> profileDetails(
      {required String email, required BuildContext context}) async {
    try {
      final uri = Uri.https(cxHead, '/profile/details/$email', {
        'MasterAPIKey': 'Qpieg2eKkXSAU1FCK7agQu2ohaT2YHHiLNHjE4BoQmvhQxIRKkg6F'
      });
      _response = await client
          .get(uri, headers: header)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        var userData = profileModelFromMap(_response.body);
        var userImage = profilePicFromMap(_response.body);

        tempDataBaseImpl.saveUserData(userData: profileModelToMap(userData));
        tempDataBaseImpl.saveUserImage(userImage: profilePicToMap(userImage));

        debugPrint('Success in fetching profile');
        return true;
      } else {
        debugPrint('Error in fetching profile');
        return false;
      }
    } catch (_) {
      debugPrint('Exception in fetching profile');
      return false;
    }
  }

  @override
  Future<void> uploadImage(
      {required String imageBytes,
      required BuildContext context,
      required email}) async {
    showLoaderDialog(context);
    var userData = {'profile_pic': imageBytes};
    var encodeToJson = jsonEncode(userData);
    try {
      final uri = Uri.https(cxHead, '/profile/edit/details/$email',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        profileDetails(email: email, context: context).then((value) => {
              Fluttertoast.showToast(msg: 'Photo upload successful'),
              Navigator.pop(context)
            });
        if(imageUploader.value){
          Navigator.pop(context);
          imageUploader.value = false;
        }
      } else {
        Fluttertoast.showToast(msg: 'Photo upload failed');
        Navigator.pop(context);
      }
    } catch (_) {
      Navigator.pop(context);
    }
  }

  @override
  Future<void> changePassword(
      {required previousPassword,
      required newPassword,
      required email,
      required BuildContext context}) async {
    showLoaderDialog(context);
    var userData = {
      'previous_password': previousPassword,
      'new_password': newPassword
    };
    var encodeToJson = jsonEncode(userData);
    try {
      final uri = Uri.https(cxHead, '/auth/change_password/$email');
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      Navigator.pop(context);

      if (_response.statusCode == 201) {
        Fluttertoast.showToast(msg: 'Password changed successfully');
        debugPrint('Password changed successfully');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Unable to change password');
        debugPrint('Unable to change password');
      }
    } catch (_) {}
  }

  @override
  Future<void> vendorRating(
      {required BuildContext context, required email}) async {
    try {
      final uri = Uri.https(cxHead, '/dashboard/vendor-status/$email',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});
      _response = await client.get(uri).timeout(const Duration(seconds: 15),
          onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        tempDataBaseImpl.saveVendorRating(
            vendorRating:
                vendorRatingsModelToMap(vendorRatingsFromMap(_response.body)));
        debugPrint('Fetched vendor rating');
      } else {
        debugPrint('Unable to fetch vendor rating');
      }
    } catch (_) {
      debugPrint('Exception in fetching vendor rating $_');
    }
  }

  @override
  Future<void> uploadID(
      {required String email,
      required String imagePath,
      required BuildContext context}) async {
    showLoaderDialog(context);

    var userData = {'id_doc': imagePath, 'id_type': 'nationalID'};
    var encodeToJson = jsonEncode(userData);

    try {
      final uri = Uri.https(cxHead, '/vendor/verify/$email/doc/add',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 30), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        profileDetails(email: email, context: context);
        Fluttertoast.showToast(msg: 'ID upload successful');
        debugPrint( 'ID upload successful');
        isIDUploaded.value = true;

        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'ID not uploaded, try again');
        debugPrint('ID not uploaded, try again');
        Navigator.pop(context);
      }
    } catch (_) {
      Fluttertoast.showToast(msg: 'ID not uploaded, try again');
      debugPrint('ID not uploaded, try again');
      Navigator.pop(context);
    }
  }
}
