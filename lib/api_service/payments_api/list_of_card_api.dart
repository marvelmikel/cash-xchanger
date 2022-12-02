import 'dart:async';
import 'dart:convert';

import 'package:cash_xchanger/database/models/banks_model/bank_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../database/models/cards_model/card_model.dart';
import '../../helpers/helpers.dart';
import '../service.dart';

abstract class CardsService {
  Future<List<CardDetail>> getCards({required String email});

  Future<List<BankDetail>> getBanks({required String email});

  Future<bool> verifyPassword(
      {required String email,
      required String password,
      required BuildContext context});
}

class CardServiceImpl extends CardsService {
  late Response _response;

  final _authorizationHeader = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer sk_test_03e1b8633a6266c14cc23bfba60dca244bda02a4',
    'Accept': 'application/json'
  };

  @override
  Future<List<CardDetail>> getCards({required String email}) async {
    try {
      final uri = Uri.https(cxHead, '/payment/card/details/$email',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});
      _response = await client
          .get(uri, headers: _authorizationHeader)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        var errorMessage = 'The connection has timed out, Please try again';
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        return cardModelFromMap(_response.body).cardDetails;
      } else {
        debugPrint('Unable to get cards');
        return [];
      }
    } catch (error) {
      debugPrint('Error in getting cards');
      return [];
    }
  }

  @override
  Future<List<BankDetail>> getBanks({required String email}) async {
    try {
      final uri = Uri.https(cxHead, '/payment/bank/details/$email',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});
      _response = await client
          .get(uri, headers: _authorizationHeader)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        var errorMessage = 'The connection has timed out, Please try again';
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        return bankModelFromMap(_response.body).bankDetails;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  @override
  Future<bool> verifyPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    var userData = {'email': email, 'password': password};

    showLoaderDialog(context);

    var encodeToJson = jsonEncode(userData);

    try {
      final uri = Uri.https(cxHead, '/login');
      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        Fluttertoast.showToast(msg: errorMessage);
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        debugPrint('Password verified');
        Fluttertoast.showToast(msg: 'Password verified');
        Navigator.pop(context);
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Incorrect Password');
        Navigator.pop(context);
        return false;
      }
    } catch (_) {
      debugPrint('Unable to verify password');
      Navigator.pop(context);
      return false;
    }
  }
}
