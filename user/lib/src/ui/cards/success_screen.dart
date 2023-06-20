import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared/shared.dart';

class SuccessScreen extends ConsumerWidget {
  const SuccessScreen({Key? key, required this.successText}) : super(key: key);

  final String successText;

  @override
  Widget build(BuildContext context, ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: GlobalColors.materialPrimaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/blue_confirmation_icon.svg'),
              const SizedBox(height: 40),
              Text(
                'Successful',
                style: GlobalTextStyles.regularTextWhite(
                    context: context, fontSize: 30),
              ),
              const SizedBox(height: 10),
              Text(
                'New credit card added to \nyour account',
                textAlign: TextAlign.center,
                style: GlobalTextStyles.regularTextWhite(context: context),
              ),
              const SizedBox(height: 60),
              GlobalButton(
                title: 'Go Home',
                onPressed: () => ref.read(navProvider).navigateTo(
                    ref.read(profileViewModelProviderV1).currentUser.role ==
                            'user'
                        ? Routes.userDashBoard
                        : Routes.vendorDashboard),
              )
            ],
          ),
        ),
      ),
    );
  }
}
