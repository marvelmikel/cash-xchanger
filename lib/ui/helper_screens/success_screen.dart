import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_gray_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../cubit/profile_cubit/profile_cubit.dart';
import '../../dependency/get_it.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/routes.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key, required this.successText}) : super(key: key);

  final String successText;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: GlobalColors.materialPrimaryColor,
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/blue_confirmation_icon.svg'),
                  const SizedBox(height: 40),
                  Text(
                    successText,
                    style: GlobalTextStyles.regularTextWhite(context: context),
                  ),
                  const SizedBox(height: 60),
                  GlobalGrayButton(
                    buttonText: 'Continue',
                    horizontalMargin: 30,
                    onTap: () => getItInstance<NavigationServiceImpl>()
                        .navigateTo(
                            state.profileModel!.userDetails.userRole == 'user'
                                ? Routes.userDashBoard
                                : Routes.vendorDashboard),
                  )
                ],
              )));
        },
      ),
    );
  }
}
