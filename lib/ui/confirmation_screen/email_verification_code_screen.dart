import 'package:cash_xchanger/database/models/auth/Verify_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import '../../cubit/auth_cubit/register_cubit.dart';
import '../../dependency/get_it.dart';
import '../../helpers/colors.dart';
import '../../helpers/text_styles.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/routes.dart';
import '../global_widgets/global_button.dart';
import '../shared_ui/enter_pin_screen/enter_pin_button_widget.dart';
import '../shared_ui/enter_pin_screen/enter_pin_keypad_buttons.dart';
import '../shared_ui/enter_pin_screen/pin_text_field_widget.dart';
import '../sign_up_screen/user_sign_up_screen.dart';

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
                  padding: EdgeInsets.only(top: 7.h, left: 2.h, right: 2.h),
                  child: Text(
                    'Enter pin',
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.blueBoldText(
                        context: context, fontSize: 32),
                  ),
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.only(
                    left: 2.h,
                  ),
                  child: Text(
                    'Please enter the 4 digit pin that was sent to your email',
                    style: GlobalTextStyles.regularText(context: context),
                  ),
                ),
                SizedBox(height: 3.h),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    decoration: BoxDecoration(
                        color: GlobalColors.globalWhite,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const PinTextField(),
                        const EnterPinKeypadButtons(),
                        ValueListenableBuilder(
                            valueListenable: registerEmail,
                            builder: (context, String emailValue, child) {
                              return GlobalButton(
                                  buttonText: 'Proceed',
                                  isButtonColorGreen: true,
                                  onTap: () {
                                    if (value.length == 4) {
                                      context
                                          .read<RegisterCubit>()
                                          .validateOtp(
                                              payload: VerifyModel(
                                                  otp: value,
                                                  email: emailValue),
                                              context: context)
                                          .then(
                                              (value) => inputText.value = '');
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Pin must be 4 digits');
                                    }
                                  });
                            }),
                        SizedBox(height: 3.h)
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
