import 'package:flutter/material.dart';

import 'colors.dart';

class GlobalTextStyles {
  GlobalTextStyles._();
  static TextStyle regularText({
    required BuildContext context,
    fontFamily = 'nunito',
    double fontSize = 16,
    int alpha = 190,
  }) {
    return TextStyle(
        fontFamily: 'nunito',
        color: GlobalColors.primaryBlack.withAlpha(alpha),
        fontSize: fontSize);
  }

  static TextStyle regularMediumW(
      {required BuildContext context, double fontSize = 16}) {
    return TextStyle(
        fontFamily: 'nunito',
        color: GlobalColors.primaryBlack,
        fontWeight: FontWeight.w500,
        fontSize: fontSize);
  }

  static TextStyle regularMediumH({double fontSize = 16, int alpha = 200}) {
    return TextStyle(
        fontFamily: 'nunito',
        color: GlobalColors.primaryBlack.withAlpha(alpha),
        fontWeight: FontWeight.w700,
        fontSize: fontSize);
  }

  static TextStyle regularTextPurple(
      {required BuildContext context, double fontSize = 14}) {
    return TextStyle(
        fontFamily: 'nunito',
        color: GlobalColors.primaryPurple,
        fontSize: fontSize);
  }

  static TextStyle regularTextWhite(
      {required BuildContext context, double fontSize = 16, int alpha = 250}) {
    return TextStyle(
        fontFamily: 'nunito',
        color: GlobalColors.globalWhite.withAlpha(alpha),
        fontSize: fontSize);
  }

  static TextStyle grayMediumText(
      {required BuildContext context, double fontSize = 24}) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'nunito',
      color: GlobalColors.primaryBlack.withAlpha(50),
      height: 1.2,
      fontSize: fontSize,
    );
  }

  static TextStyle regularMediumWhite({double fontSize = 18}) {
    return TextStyle(
        fontFamily: 'nunito',
        color: GlobalColors.globalWhite,
        fontWeight: FontWeight.w500,
        fontSize: fontSize);
  }

  static TextStyle regularMediumWhiteH(
      {required BuildContext context, double fontSize = 22, int alpha = 200}) {
    return TextStyle(
        fontFamily: 'nunito',
        color: GlobalColors.globalWhite.withAlpha(alpha),
        fontWeight: FontWeight.w700,
        fontSize: fontSize);
  }

  static TextStyle regularTextWashedWhite(
      {required BuildContext context, double fontSize = 18}) {
    return TextStyle(
        fontFamily: 'nunito',
        color: GlobalColors.globalWhite.withAlpha(100),
        fontSize: fontSize);
  }

  static TextStyle regularGreenText(
      {required BuildContext context, double fontSize = 17, int alpha = 190}) {
    return TextStyle(
        fontFamily: 'nunito',
        color: GlobalColors.primaryGreen.withAlpha(alpha),
        fontSize: fontSize);
  }

  static TextStyle regularGreenTexMedium(
      {required BuildContext context, double fontSize = 17}) {
    return TextStyle(
        fontFamily: 'nunito',
        fontWeight: FontWeight.w700,
        color: GlobalColors.primaryGreen,
        fontSize: fontSize);
  }

  static TextStyle boldText(
      {required BuildContext context,
      double fontSize = 24,
      Color color = const Color(0xff061E38)}) {
    return TextStyle(
      fontWeight: FontWeight.w900,
      color: color,
      fontFamily: 'nunito',
      height: 1.2,
      fontSize: fontSize,
    );
  }

  static TextStyle blueMediumText(
      {required BuildContext context, double fontSize = 24}) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'nunito',
      color: GlobalColors.primaryBlue,
      height: 1.2,
      fontSize: fontSize,
    );
  }

  static TextStyle blueMediumTextB(
      {required BuildContext context, double fontSize = 24}) {
    return TextStyle(
      fontWeight: FontWeight.w700,
      color: GlobalColors.primaryBlue,
      fontFamily: 'nunito',
      height: 1.2,
      fontSize: fontSize,
    );
  }

  static TextStyle greenMediumText(
      {required BuildContext context, double fontSize = 24}) {
    return TextStyle(
      fontWeight: FontWeight.w700,
      color: GlobalColors.primaryGreen,
      fontFamily: 'nunito',
      height: 1.2,
      fontSize: fontSize,
    );
  }

  static TextStyle purpleBoldText(
      {required BuildContext context, double fontSize = 24}) {
    return TextStyle(
        fontWeight: FontWeight.w800,
        color: GlobalColors.purpleBlue,
        fontFamily: 'nunito',
        fontSize: fontSize);
  }

  static TextStyle boldGreenText(
      {required BuildContext context, double fontSize = 25}) {
    return TextStyle(
        fontFamily: 'nunito',
        fontWeight: FontWeight.w800,
        color: GlobalColors.primaryGreen.withAlpha(190),
        fontSize: fontSize);
  }
}
