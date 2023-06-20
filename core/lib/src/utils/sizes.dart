import 'package:flutter/material.dart';

class GlobalSizes {
  GlobalSizes._();

  static dynamic globalWidth(BuildContext context, double size) {
    return MediaQuery.of(context).size.width * size;
  }

  static dynamic globalHeight(BuildContext context, double size) {
    return MediaQuery.of(context).size.height * size;
  }

  static double topSpacing(BuildContext context) {
    return globalWidth(context, 0.2);
  }
}
