import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';

import 'enter_pin_button_widget.dart';

class PinTextField extends StatelessWidget {
  const PinTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: inputText,
        builder: (Context, String textValue, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 50),
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
      width: 60,
      height: 60,
      padding: EdgeInsets.only(top: 8),
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
