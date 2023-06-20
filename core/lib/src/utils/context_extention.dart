
import 'package:flutter/material.dart';
export 'package:sizer/sizer.dart';

extension ContextExtension on BuildContext {

  void closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus =
    FocusScope.of(context); // SHOULD BE builderContext
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
  String tokenFormatter(String n) {
    var numArr = n.split('');
    String revStr = '';
    int thousands = 0;
    for (var i = numArr.length - 1; i >= 0; i--) {
      if (numArr[i].toString() == '.') {
        thousands = 0;
      } else {
        thousands++;
      }
      revStr = revStr + numArr[i].toString();
      if (thousands == 4 && i > 0) {
        thousands = 0;
        revStr = revStr + '  ';
      }
    }
    return revStr.split('').reversed.join('');
  }

  void requestFocus(FocusNode nextFocus) =>
      FocusScope.of(this).requestFocus(nextFocus);
}