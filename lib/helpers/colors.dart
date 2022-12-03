import 'package:flutter/material.dart';

class GlobalColors {
  static Color primaryBlue = const Color(0xff061E38);
  static Color primaryBlack = const Color(0xff111111);
  static Color primaryGreen = const Color(0xff0ACF83);
  static Color primaryPurple = const Color(0xffed2e7e);
  static Color primaryPurpleLight = const Color(0xfffff2f7);
  static Color washedWhite = const Color(0xffE5E5E5);
  static Color ashWhite = const Color(0xffF1F1F1);
  static Color ashWhiteB = const Color(0xfff8f8f8);
  static Color ashWhiteC = const Color(0xffe5e5e5);
  static Color globalWhite = const Color(0xffffffff);
  static Color purpleBlue = const Color(0xff897FFE);
  static Color deepPurple = const Color(0xff654de4);
  static Color borderStroke = const Color(0xff1201D6);

  static const MaterialColor materialPrimaryColor = MaterialColor(
    0xff0acf83, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff0acf83), //10%
      100: Color(0xff09ba76), //20%
      200: Color(0xff08a669), //30%
      300: Color(0xff07915c), //40%
      400: Color(0xff067c4f), //50%
      500: Color(0xff056842), //60%
      600: Color(0xff045334), //70%
      700: Color(0xff033e27), //80%
      800: Color(0xff02291a), //90%
      900: Color(0xff01150d), //100%
    },
  );
}
