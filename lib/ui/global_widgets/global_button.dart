import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton(
      {Key? key,
      required this.buttonText,
      this.isButtonColorGreen = false,
      this.horizontalMargin = 0,
      this.height = 60,
      required this.onTap})
      : super(key: key);

  final String buttonText;
  final bool isButtonColorGreen;
  final double horizontalMargin;
  final double height;
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
            color: isButtonColorGreen
                ? GlobalColors.primaryGreen
                : GlobalColors.primaryBlue,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          buttonText,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: GlobalColors.globalWhite),
        ),
      ),
    );
  }
}
