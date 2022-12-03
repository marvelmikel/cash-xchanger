import 'dart:async';
import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../helpers/helpers.dart';
import '../service.dart';
import 'paystack_payment.dart';

abstract class TopUpService {
  Future<void> topUp(
      {required String email,
      required String amount,
      required BuildContext context});
}

class TopUpImpl implements TopUpService {
  @override
  Future<void> topUp(
      {required String email,
      required String amount,
      required BuildContext context}) async {
    late Response _response;

    try {
      final uri = Uri.https(cxHead, 'payment/fund/$email',
          {'APIKey': 'Pra8CPHHySKFEBYvgHRan1wP7LOnaoYkgT7J1dNw1AR6xlNt8u9c6'});

      showLoaderDialog(context);

      var data = {
        'amount': int.tryParse(amount),
        'transaction_type': 'funding',
        'cash_type': 'mint,stale',
        'remarks': 'paying self'
      };

      if (kDebugMode) {
        print(data);
      }

      var encodeToJson = jsonEncode(data);

      _response = await client
          .post(uri, body: encodeToJson, headers: header)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        Navigator.pop(context);
        var errorMessage = 'The connection has timed out, Please try again';
        var snackBar = SnackBar(content: Text(errorMessage));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        throw TimeoutException(errorMessage);
      });

      debugPrint('Respnse: ${_response.body}');

      if (_response.statusCode == 201) {
        Navigator.pop(context);

        var jsonBody = json.decode(_response.body);
        var accessCode = jsonBody['access_code'];
        var reference = jsonBody['reference'];

        PaystackPayment().chargeCardAndMakePayment(
            context: context,
            price: int.tryParse(amount)!,
            email: email,
            accessCode: accessCode,
            reference: reference);
      } else {
        Navigator.pop(context);

        var errorMessage = 'Unable to perform transaction';
        var snackBar = SnackBar(content: Text(errorMessage));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (_) {}
  }
}
