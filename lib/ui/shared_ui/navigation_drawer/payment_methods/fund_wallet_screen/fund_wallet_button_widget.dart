import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';

final keypadEquation = ValueNotifier('');

class FundWalletKeypadButtonWidget extends StatelessWidget {
  const FundWalletKeypadButtonWidget(
      {Key? key, required this.buttonText, required this.textController})
      : super(key: key);

  final String buttonText;
  final TextEditingController textController;

  calculation(BuildContext context, String buttonText, String equation) {
    if (buttonText == '⌫') {
      try {
        keypadEquation.value = equation.substring(0, equation.length - 1);
      } catch (_) {
        debugPrint('Keypad error: \n $_');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: keypadEquation,
        builder: (context, keypadValue, child) {
          return InkWell(
            onTap: () {
              if (keypadEquation.value.length < 9) {
                textController.text =
                    keypadEquation.value = keypadEquation.value + buttonText;
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
