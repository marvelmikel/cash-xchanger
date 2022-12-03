import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/back_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../dependency/get_it.dart';
import '../../../navigation/navigation_service.dart';
import '../../../navigation/routes.dart';
import 'enter_pin_button_widget.dart';
import 'enter_pin_keypad_buttons.dart';
import 'pin_text_field_widget.dart';

class EnterPinScreen extends StatelessWidget {
  const EnterPinScreen({Key? key, required this.amount}) : super(key: key);

  final String amount;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: inputText,
        builder: (context, String value, child) {
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
                            buttonText: 'Proceed',
                            isButtonColorGreen: true,
                            onTap: () {
                              if (value.length == 4) {
                                getItInstance<NavigationServiceImpl>()
                                    .navigateTo(Routes.successScreen,
                                        arguments: 'Withdrawal Successful');
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Pin must be 4 digits');
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
