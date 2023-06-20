import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared/shared.dart';
import 'package:user/user.dart';
import 'package:avatar_glow/avatar_glow.dart';

class ConnectVendorScreen extends ConsumerWidget {
  const ConnectVendorScreen({Key? key, required this.params}) : super(key: key);
  final ConnectParams params;
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: GlobalColors.globalWhite,
      body: Column(
        children: [
          const ProfileBackButtonWidget(text: 'Request cash'),
          AvatarGlow(
            glowColor: GlobalColors.primaryGreen,
            endRadius: 150,
            duration: const Duration(milliseconds: 1000),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: const Duration(milliseconds: 100),
            child: SvgPicture.asset('assets/images/money_bag_icon.svg',
                height: 60),
          ),
          SvgPicture.asset(
            'assets/images/match_icon.svg',
          ),
          const SizedBox(height: 40),
          GlobalButton(
              title: 'Cancel', onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}
