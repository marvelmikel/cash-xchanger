import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:sizer/sizer.dart';

import '../../ui.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.globalWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Settings'),
        centerTitle: true,
        actions: [
          MenuFiller(
            icon: Icons.menu,
            onClick: () {},
            color: GlobalColors.lightGreen,
            bgColor: Colors.transparent,
            size: 30,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                SecurityWidget(
                  widget1: 'bell',
                  widget2: 'Notifications',
                  hasSwitch: true,
                  status: status,
                  onToggle: (val) {
                    setState(() {
                      status = val;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () =>
                      ref.read(navProvider).navigateTo(Routes.passwordRest),
                  // showModalBottomSheet(
                  //     context: context,
                  //     isScrollControlled: true,
                  //     backgroundColor: Colors.transparent,
                  //     builder: (context) => const ChangePasswordBottomSheet()),
                  child: SecurityWidget(
                      widget1: 'security_icon', widget2: 'Password'),
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
  SecurityWidget(
      {Key? key,
      required this.widget1,
      required this.widget2,
      this.hasSwitch = false,
      this.onToggle,
      this.status = false})
      : super(key: key);

  final String widget1;
  final String widget2;
  bool? hasSwitch;
  bool? status;
  Function(bool)? onToggle;

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
                hasSwitch!
                    ? FlutterSwitch(
                        width: 62.0,
                        height: 2.5.h,
                        activeColor: GlobalColors.lightGreen,
                        toggleSize: 1.5.h,
                        value: status!,
                        borderRadius: 30.0,
                        padding: 1.0,
                        showOnOff: false,
                        onToggle: onToggle!,
                      )
                    : Text(
                        'Change',
                        style:
                            GlobalTextStyles.regularGreenText(context: context),
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
