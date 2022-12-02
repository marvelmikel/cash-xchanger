import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../cubit/profile_cubit/profile_cubit.dart';
import '../../../../dependency/get_it.dart';
import '../../../../helpers/helpers.dart';
import '../../../../navigation/navigation_service.dart';
import '../../../../navigation/routes.dart';

class EwalletWidget extends StatelessWidget {
  const EwalletWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My e-wallet',
                  style: GlobalTextStyles.regularText(
                      context: context, fontSize: 18)),
              const PayBalanceWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class PayBalanceWidget extends StatelessWidget {
  const PayBalanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          width: double.infinity,
          margin: const EdgeInsets.only(top: 25),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              color: GlobalColors.primaryBlue,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My balance',
                      style: GlobalTextStyles.regularTextWhite(
                          context: context, fontSize: 14)),
                  state.transactionBalanceModel == null
                      ? Text('N 0.00',
                          style: GlobalTextStyles.boldGreenText(
                              context: context, fontSize: 20))
                      : Text(
                          formatFigures(double.tryParse(
                              state.transactionBalanceModel!.userBalance)!),
                          style: GlobalTextStyles.boldGreenText(
                              context: context, fontSize: 20)),
                ],
              ),
              GestureDetector(
                  onTap: () => getItInstance<NavigationServiceImpl>()
                      .navigateTo(Routes.fundWalletScreen),
                  child: SvgPicture.asset('assets/images/gene_top_up_icon.svg'))
            ],
          ),
        );
      },
    );
  }
}
