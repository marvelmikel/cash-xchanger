
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';
showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CupertinoActivityIndicator(),
        Container(
          margin: const EdgeInsets.only(left: 7),
          child: const Text('Loading...'),
        ),
      ],
    ),
  );
  showCupertinoDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(onWillPop: () async => false, child: alert);
    },
  );
}

bool isValidEmail(BuildContext context, String email) {
  bool emailValid = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\'
  r's@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.'
  r'[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.'
  r')+[a-zA-Z]{2,}))$')
      .hasMatch(email);
  if (emailValid) {
    return true;
  } else {
    return false;
  }
}



String convertToPhone(String code) {
  String s = '234';
  var codeString = s + (int.tryParse(code)).toString();
  return codeString;
}

double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + 
          cos(lat1 * p) * cos(lat2 * p) * 
          (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

String formatFigures(double amount) {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  return '${myFormat.simpleCurrencySymbol('NGN')} '
      '${myFormat.format(amount)}';
}

String formatFiguresSeparator(double amount) {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  return myFormat.format(amount);
}