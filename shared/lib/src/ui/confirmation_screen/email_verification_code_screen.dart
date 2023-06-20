import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/src/ui/sign_up_screen/viewmodel/signup_vm.dart';
import 'package:sizer/sizer.dart';
import '../../../shared.dart';
import '../enter_pin_screen/enter_pin_button_widget.dart';
import '../enter_pin_screen/enter_pin_keypad_buttons.dart';
import '../enter_pin_screen/pin_text_field_widget.dart';
import '../overview_screen/user_cash_widget.dart';

enum PinType { reset, signup }

class VerifyPhoneScreen extends ConsumerWidget {
  VerifyPhoneScreen({Key? key, this.pinType = PinType.signup})
      : super(key: key);
  final PinType pinType;

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(signupVM);
    return ValueListenableBuilder(
        valueListenable: inputText,
        builder: (context, TextEditingController value, child) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.only(top: 7.h, left: 2.h, right: 2.h),
                  child: Text(
                    'SMS Verification',
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.boldText(
                        context: context, fontSize: 32),
                  ),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.only(
                    left: 2.h,
                  ),
                  child: Text(
                    'Please enter the 4 digit pin that was sent to your phone',
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
                    child: ValueListenableBuilder(
                        valueListenable: userType,
                        builder: (context, user, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const PinTextField(),
                              const EnterPinKeypadButtons(),
                              ValueListenableBuilder(
                                  valueListenable: registerEmail,
                                  builder: (context, RegisterPayload regPayload,
                                      child) {
                                    return ValueListenableBuilder(
                                        valueListenable: userType,
                                        builder: (context, user, child) {
                                          return GlobalButton(
                                              title: 'Proceed',
                                              onPressed: () {
                                                if (value.text.length == 5) {
                                                  if (pinType ==
                                                      PinType.signup) {
                                                    controller.validateOtp(
                                                        code: value.text,
                                                        context: context);
                                                  } else {
                                                    resetModelListener
                                                        .value.otp = value.text;
                                                    inputText.value.text = '';
                                                    ref
                                                        .read(navProvider)
                                                        .navigateTo(Routes
                                                            .passwordRest);
                                                  }
                                                } else {
                                                  alert(
                                                      description:
                                                          'Pin must be 4 digits');
                                                }
                                              });
                                        });
                                  }),
                              ValueListenableBuilder(
                                  valueListenable: registerEmail,
                                  builder: (context, RegisterPayload regPayload,
                                      child) {
                                    return InkWell(
                                      onTap: () => controller.resendOtp(
                                          context: context),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Didn\'t get code? ',
                                          style: GlobalTextStyles.regularText(
                                              context: context),
                                          children: [
                                            TextSpan(
                                                text: 'Resend',
                                                style: GlobalTextStyles
                                                    .regularGreenText(
                                                        context: context)),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                              SizedBox(height: 3.h)
                            ],
                          );
                        }),
                  ),
                )
              ],
            ),
          );
        });
  }
}
