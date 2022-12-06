import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/sizes.dart';
import '../../helpers/text_styles.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/routes.dart';
import '../global_widgets/global_button.dart';

class VerifyEmailPromptScreen extends StatelessWidget {
  const VerifyEmailPromptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    style: GlobalTextStyles.blueBoldText(
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
                  GlobalButton(
                    buttonText: 'Enter code',
                    isButtonColorGreen: true,
                    onTap: () => getItInstance<NavigationServiceImpl>()
                        .navigateTo(Routes.verifyEmailScreen),
                  ),
                  SizedBox(height: GlobalSizes.globalWidth(context, 0.19)),
                ]),
          ),
        ),
      ),
    );
  }
}
