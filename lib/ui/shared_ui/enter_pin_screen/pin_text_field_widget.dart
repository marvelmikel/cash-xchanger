import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'enter_pin_button_widget.dart';

class PinTextField extends StatelessWidget {
  const PinTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: inputText,
        builder: (context, String textValue, child) {
          return Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PinItem(pinText: textValue.isNotEmpty ? '*' : ''),
                PinItem(pinText: textValue.length > 1 ? '*' : ''),
                PinItem(pinText: textValue.length > 2 ? '*' : ''),
                PinItem(pinText: textValue.length > 3 ? '*' : ''),
              ],
            ),
          );
        });
  }
}

class PinItem extends StatelessWidget {
  const PinItem({Key? key, required this.pinText}) : super(key: key);

  final String pinText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.h,
      height: 8.h,
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: pinText.isNotEmpty
                  ? GlobalColors.deepPurple
                  : GlobalColors.primaryBlack.withAlpha(50))),
      alignment: Alignment.center,
      child: Text(
        pinText,
        style: GlobalTextStyles.purpleBoldText(context: context),
      ),
    );
  }
}
