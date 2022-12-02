import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/profile_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'change_password_bottom_sheet.dart';
import 'change_pin_bottom_sheet.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.globalWhite,
      body: Column(
        children: [
          const SizedBox(height: 20),
          const ProfileBackButtonWidget(
              text: 'Security', isImageVisible: false),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const ChangePasswordBottomSheet()),
                  child: const SecurityWidget(
                      widget1: 'security_icon', widget2: 'Password'),
                ),
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const ChangePinBottomSheet()),
                  child: const SecurityWidget(
                      widget1: 'pin_icon', widget2: 'Transaction pin'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecurityWidget extends StatelessWidget {
  const SecurityWidget({Key? key, required this.widget1, required this.widget2})
      : super(key: key);

  final String widget1;
  final String widget2;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalColors.globalWhite,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/$widget1.svg', height: 22),
                    const SizedBox(width: 20),
                    Text(
                      widget2,
                      style: GlobalTextStyles.regularText(
                          context: context, fontSize: 20),
                    ),
                  ],
                ),
                Text(
                  'Change',
                  style: GlobalTextStyles.regularGreenText(context: context),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Divider()
          ],
        ),
      ),
    );
  }
}
