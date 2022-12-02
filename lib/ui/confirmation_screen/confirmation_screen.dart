import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/navigation/navigation_service.dart';
import 'package:cash_xchanger/navigation/routes.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key, required this.user}) : super(key: key);
  final String user;

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
                SizedBox(height: GlobalSizes.globalWidth(context, 0.1)),
                Center(
                    child:
                        SvgPicture.asset('assets/images/timeline_three.svg')),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.3)),
                Center(
                    child: SvgPicture.asset(
                        'assets/images/blue_confirmation_icon.svg')),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.15)),
                Text(
                  'Congratulations, $user',
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.blueMediumText(context: context),
                ),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.04)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'We ve completed your onboarding, you can start using cXapp',
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.regularText(context: context),
                  ),
                ),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.19)),
                GlobalButton(
                  buttonText: 'Launch CXapp',
                  isButtonColorGreen: true,
                  onTap: () => getItInstance<NavigationServiceImpl>()
                      .navigateTo(Routes.userDashBoard),
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
