import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../ui.dart';
import 'user_cash_widget.dart';

class OverviewScreen extends ConsumerWidget {
   OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
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
                      'How are you planning to \nuse CashX?',
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.boldText(context: context),
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
                        const UserCashWidget(
                            inActiveImage: 'user_inactive.svg',
                            activeImage: 'user_active.svg',
                            title: 'User',
                            description:
                                'Request for minted cash, easily and faster. Transfer funds and buy airtime',
                            userRole: 'user'),
                        SizedBox(
                            width: GlobalSizes.globalWidth(context, 0.025)),
                        const UserCashWidget(
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
                            title: 'Sign up',

                            isDisabled: userType.value == 'unselected',
                            onPressed: () {
                              // context.read<PrivacyCubit>().loadPrivacy();
                              ref
                                  .read(navProvider)
                                  .navigateTo(Routes.signUpScreen);
                            });
                      },
                    ),
                    SizedBox(height: GlobalSizes.globalWidth(context, 0.04)),
                    ValueListenableBuilder(
                        valueListenable: userType,
                        builder: (context, value, child) {
                          return GlobalButton(
                            title: 'Login',
                            background: Colors.transparent,
                            borderColor:  Color(0xff083F08),
                            isDisabled: userType.value == 'unselected',
                            foreground: GlobalColors.primaryBlue,
                            onPressed: () => ref
                                .read(navProvider)
                                .navigateTo(Routes.loginScreen),
                          );
                        }),
                    SizedBox(height: GlobalSizes.globalHeight(context, 0.04)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        'By tapping Signup and using CashX App,  you agree to our Terms and Privacy Policy',
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
