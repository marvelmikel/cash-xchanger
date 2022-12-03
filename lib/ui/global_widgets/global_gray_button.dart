import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlobalGrayButton extends StatelessWidget {
  const GlobalGrayButton(
      {Key? key,
      required this.buttonText,
      this.horizontalMargin = 0,
      this.height = 60,
      this.isIDUpload = false,
      required this.onTap})
      : super(key: key);

  final String buttonText;
  final double horizontalMargin;
  final double height;
  final bool isIDUpload;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
        alignment: Alignment.center,
        width: GlobalSizes.globalWidth(context, 1),
        decoration: BoxDecoration(
            color: isIDUpload
                ? GlobalColors.primaryGreen
                : GlobalColors.ashWhite.withAlpha(180),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          buttonText,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: GlobalSizes.globalWidth(context, 0.045),
              color: GlobalColors.primaryBlack.withAlpha(150)),
        ),
      ),
    );
  }
}
