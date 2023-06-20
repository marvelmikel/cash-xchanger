import 'package:core/core.dart';
import 'package:flutter/material.dart';

final pinKeypadEquation = ValueNotifier('');
final inputText = ValueNotifier<TextEditingController>(TextEditingController());

class EnterPinKeypadButtonWidget extends StatelessWidget {
  const EnterPinKeypadButtonWidget({Key? key, required this.buttonText})
      : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: inputText,
        builder: (context, TextEditingController pinCode, child) {
          return InkWell(
            onTap: () {
              if (pinCode.text.length < 5) {
                inputText.value.text = pinCode.text + buttonText;
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
