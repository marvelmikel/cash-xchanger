import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../shared.dart';



class ConfirmationScreen extends ConsumerWidget {
  const ConfirmationScreen({Key? key, required this.user}) : super(key: key);
  final String user;

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
                SvgPicture.asset(GlobalAssets.iconBlue),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.1)),
                Center(
                    child:
                        SvgPicture.asset('assets/images/timeline_three.svg')),
                SizedBox(height: 10.h),
                Center(
                    child: SvgPicture.asset(
                        'assets/images/blue_confirmation_icon.svg')),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.15)),
                Text(
                  'Congratulations, $user',
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.blueMediumText(context: context),
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'We ve completed your onboarding, you can start using CashX',
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.regularText(context: context),
                  ),
                ),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.19)),
                GlobalButton(
                  title: 'Launch CashX',
                  onPressed: () => ref.read(navProvider).navigateTo(
                       Routes.userDashBoard),
                ),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.04))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
