import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton(
      {Key? key,
      required this.buttonText,
      this.isButtonColorGreen = false,
      this.horizontalMargin = 0,
      this.height = 60,
      this.outLined = false,
      this.isDisabled = false,
      this.forground = Colors.white,
      required this.onTap})
      : super(key: key);

  final String buttonText;
  final bool isButtonColorGreen;
  final bool outLined;
  final double horizontalMargin;
  final double height;
  final Color forground;
  final bool isDisabled;
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
            color: backgroundSwitcher(
                isDisabled: isDisabled,
                isGreenButton: isButtonColorGreen,
                outlined: outLined),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: outLined
                    ? isDisabled
                        ? GlobalColors.primaryGreen.withOpacity(0.2)
                        : GlobalColors.primaryGreen
                    : Colors.transparent,
                width: 1.2)),
        child: Text(
          buttonText,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: isDisabled
                  ? isButtonColorGreen
                      ? forground
                      : forground.withOpacity(0.4)
                  : forground),
        ),
      ),
    );
  }

  Color backgroundSwitcher({
    required bool isDisabled,
    required bool isGreenButton,
    required bool outlined,
  }) {
    if (isDisabled) {
      return outLined
          ? Colors.transparent
          : isGreenButton
              ? GlobalColors.primaryGreen.withOpacity(0.4)
              : GlobalColors.primaryBlue;
    }
    if (outLined) {
      return Colors.transparent;
    } else {
      return isGreenButton
          ? GlobalColors.primaryGreen
          : GlobalColors.primaryBlue;
    }
  }
}
/// isButtonColorGreen
               