import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

final pinKeypadEquation = ValueNotifier('');
final inputText = ValueNotifier('');

class EnterPinKeypadButtonWidget extends StatelessWidget {
  const EnterPinKeypadButtonWidget({Key? key, required this.buttonText})
      : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: inputText,
        builder: (context, String pinCode, child) {
          return InkWell(
            onTap: () {
              if (pinCode.length < 4) {
                inputText.value = pinCode + buttonText;
              }
            },
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              padding: const EdgeInsets.all(25),
              child: Text(
                buttonText,
                style: GlobalTextStyles.blueMediumText(
                    context: context, fontSize: 30),
              ),
            ),
          );
        });
  }
}
