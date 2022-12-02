import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'enter_pin_button_widget.dart';

class EnterPinKeypadButtons extends StatelessWidget {
  const EnterPinKeypadButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: inputText,
        builder: (context, String pinCode, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      EnterPinKeypadButtonWidget(buttonText: '1'),
                      EnterPinKeypadButtonWidget(buttonText: '2'),
                      EnterPinKeypadButtonWidget(buttonText: '3'),
                    ]),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      EnterPinKeypadButtonWidget(buttonText: '4'),
                      EnterPinKeypadButtonWidget(buttonText: '5'),
                      EnterPinKeypadButtonWidget(buttonText: '6'),
                    ]),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      EnterPinKeypadButtonWidget(buttonText: '7'),
                      EnterPinKeypadButtonWidget(buttonText: '8'),
                      EnterPinKeypadButtonWidget(buttonText: '9'),
                    ]),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('          '),
                      const EnterPinKeypadButtonWidget(buttonText: '0'),
                      Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            if (pinCode.isNotEmpty) {
                              inputText.value =
                                  pinCode.substring(0, pinCode.length - 1);
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                  'assets/images/back_icon.svg')),
                        ),
                      ),
                    ]),
              ],
            ),
          );
        });
  }
}
