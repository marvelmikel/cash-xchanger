import 'package:avatar_glow/avatar_glow.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/ui/global_widgets/global_gray_button.dart';
import 'package:cash_xchanger/ui/global_widgets/profile_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../cubit/book_cash_cubit/book_cash_cubit.dart';

class ConnectVendorScreen extends StatelessWidget {
  const ConnectVendorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<BookCashCubit>().getNearbyVendor(context: context);
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
          GlobalGrayButton(
              buttonText: 'Cancel',
              horizontalMargin: 20,
              onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}
