import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 140),
          width: GlobalSizes.globalWidth(context, 1),
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              color: GlobalColors.primaryBlue,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My balance',
                  style: GlobalTextStyles.regularTextWhite(context: context)),
          state.isDatabaseEmpty
              ?  Text('N 0.00',
              style: GlobalTextStyles.boldGreenText(context: context))
              :   Text(formatFigures(double.tryParse(state.profileModel!.userBalance)!),
              style: GlobalTextStyles.boldGreenText(context: context))
            ],
          ),
        );
      },
    );

  }
}
