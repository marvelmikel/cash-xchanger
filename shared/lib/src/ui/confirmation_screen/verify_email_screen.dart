import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared/shared.dart';
import 'package:sizer/sizer.dart';
import '../overview_screen/user_cash_widget.dart';


class VerifyEmailPromptScreen extends ConsumerWidget {
  const VerifyEmailPromptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 20, right: 20, top: GlobalSizes.topSpacing(context)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/icon_blue.svg'),
                  SizedBox(height: 20.h),
                  Center(
                      child: SvgPicture.asset('assets/images/email_icon.svg')),
                  SizedBox(height: GlobalSizes.globalWidth(context, 0.1)),
                  Text(
                    'Email Verification',
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.boldText(
                        context: context, fontSize: 25),
                  ),
                  SizedBox(height: GlobalSizes.globalWidth(context, 0.04)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Please check your email for the 4 digit code we sent to verify your account',
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.regularText(context: context),
                    ),
                  ),
                  SizedBox(height: GlobalSizes.globalWidth(context, 0.19)),
                  ValueListenableBuilder(
                      valueListenable: userType,
                      builder: (context, value, child) {
                        return GlobalButton(
                          title: 'Enter code',

                          onPressed: () => ref
                              .read(navProvider)
                              .navigateTo(Routes
                              .verifyPhoneScreen, arguments: PinType.signup),
                        );
                      }),
                  SizedBox(height: 5.h),
                  ValueListenableBuilder(
                      valueListenable: registerEmail,
                      builder: (context, RegisterPayload regPayload, child) {
                        return InkWell(
                          // onTap: () => context.read<RegisterCubit>().resendOtp(
                          //     username: regPayload.username!, context: context),
                          child: RichText(
                            text: TextSpan(
                              text: 'Didn\'t get code? ',
                              style: GlobalTextStyles.regularText(
                                  context: context),
                              children: [
                                TextSpan(
                                    text: 'Resend',
                                    style: GlobalTextStyles.regularGreenText(
                                        context: context)),
                              ],
                            ),
                          ),
                        );
                      }),
                  SizedBox(height: GlobalSizes.globalWidth(context, 0.19)),
                ]),
          ),
        ),
      ),
    );
  }
}
