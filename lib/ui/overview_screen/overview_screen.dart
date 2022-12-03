import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/helpers/global_assets.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/navigation/navigation_service.dart';
import 'package:cash_xchanger/navigation/routes.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/overview_screen/user_cash_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helpers/colors.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userType,
        builder: (context, cardPosition, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20, right: 20, top: GlobalSizes.topSpacing(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(GlobalAssets.iconBlue),
                    SizedBox(height: GlobalSizes.globalWidth(context, 0.1)),
                    SvgPicture.asset(GlobalAssets.timelineOne),
                    SizedBox(height: GlobalSizes.globalWidth(context, 0.1)),
                    Text(
                      'How are you planning to \nuse CX?',
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.blueBoldText(context: context),
                    ),
                    SizedBox(height: GlobalSizes.globalWidth(context, 0.05)),
                    const Text(
                      'We’ll streamline your signup experience accordingly.',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: GlobalSizes.globalWidth(context, 0.12)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserCashWidget(
                            inActiveImage: 'user_inactive.svg',
                            activeImage: 'user_active.svg',
                            title: 'User',
                            description:
                                'Request for minted cash, easily and faster. Transfer funds and buy airtime',
                            userRole: 'user'),
                        SizedBox(
                            width: GlobalSizes.globalWidth(context, 0.025)),
                        UserCashWidget(
                            inActiveImage: 'cash_inactive.svg',
                            activeImage: 'cash_active.svg',
                            title: 'Cash Vendor',
                            description:
                                'Harbour minted cash, deliver to users in need within the neigbourhood',
                            userRole: 'vendor'),
                      ],
                    ),
                    SizedBox(height: GlobalSizes.globalWidth(context, 0.12)),
                    ValueListenableBuilder(
                      valueListenable: userType,
                      builder: (context, value, child) {
                        return GlobalButton(
                            buttonText: 'Sign up',
                            isButtonColorGreen: true,
                            isDisabled: userType.value == 'unselected',
                            onTap: () => getItInstance<NavigationServiceImpl>()
                                .navigateTo(Routes.signUpScreen));
                      },
                    ),
                    SizedBox(height: GlobalSizes.globalWidth(context, 0.04)),
                    ValueListenableBuilder(
                        valueListenable: userType,
                        builder: (context, value, child) {
                          return GlobalButton(
                            buttonText: 'Login',
                            outLined: true,
                            isDisabled: userType.value == 'unselected',
                            forground: GlobalColors.primaryBlue,
                            onTap: () => getItInstance<NavigationServiceImpl>()
                                .navigateTo(Routes.loginScreen),
                          );
                        }),
                    SizedBox(height: GlobalSizes.globalHeight(context, 0.04)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        'By tapping Signup and using cXapp,  you agree to our Terms and Privacy Policy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: GlobalSizes.globalWidth(context, 0.035)),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
