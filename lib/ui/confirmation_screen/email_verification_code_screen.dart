import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../dependency/get_it.dart';
import '../../helpers/colors.dart';
import '../../helpers/text_styles.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/routes.dart';
import '../global_widgets/global_button.dart';
import '../shared_ui/enter_pin_screen/enter_pin_button_widget.dart';
import '../shared_ui/enter_pin_screen/enter_pin_keypad_buttons.dart';
import '../shared_ui/enter_pin_screen/pin_text_field_widget.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: inputText,
        builder: (context, String value, child) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                  child: Text(
                    'Enter pin',
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.blueBoldText(
                        context: context, fontSize: 32),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    'Please enter the 4 digit pin that was sent to your email',
                    style: GlobalTextStyles.regularText(context: context),
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
                                    .navigateTo(Routes.confirmationScreen,
                                        arguments: '');
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
