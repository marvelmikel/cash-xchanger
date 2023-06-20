import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';

import 'enter_pin_button_widget.dart';
import 'enter_pin_keypad_buttons.dart';
import 'pin_text_field_widget.dart';

class EnterPinScreen extends ConsumerWidget {
  const EnterPinScreen({Key? key, required this.amount}) : super(key: key);

  final String amount;

  @override
  Widget build(BuildContext context, ref) {
    return ValueListenableBuilder(
        valueListenable: inputText,
        builder: (context, TextEditingController value, child) {
          return Scaffold(
            backgroundColor: GlobalColors.primaryBlue,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButtonWidget(backButtonText: 'Enter pin'),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 100),
                  child: Text(
                    'Input your transaction pin',
                    style: GlobalTextStyles.regularGreenText(
                        context: context, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                        color: GlobalColors.globalWhite,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const PinTextField(),
                        const EnterPinKeypadButtons(),
                        GlobalButton(
                            title: 'Proceed',
                            onPressed: () {
                              if (value.text.length == 4) {
                                ref.read(navProvider).navigateTo(
                                    Routes.loginScreen,
                                    arguments: 'Withdrawal Successful');
                              } else {
                                alert(description: 'Pin must be 4 digits');

                              }
                            }),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
