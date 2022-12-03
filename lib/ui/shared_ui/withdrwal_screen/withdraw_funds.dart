import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../cubit/nav_bar_cubit/nav_drawer_cubit.dart';
import '../../../database/models/banks_model/bank_model.dart';
import '../../../dependency/get_it.dart';
import '../../../navigation/navigation_service.dart';
import '../../../navigation/routes.dart';
import '../../global_widgets/bank_bottom_sheet/add_bank_bottom_sheet.dart';

class WithdrawFundsScreen extends StatefulWidget {
  const WithdrawFundsScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawFundsScreen> createState() => _WithdrawFundsScreenState();
}

class _WithdrawFundsScreenState extends State<WithdrawFundsScreen> {
  @override
  void initState() {
    context.read<NavDrawerCubit>().getBankAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavDrawerCubit, NavDrawerState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: GlobalColors.primaryBlue,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BackButtonWidget(backButtonText: 'Withdraw Funds'),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 100),
                child: Text(
                  'Select the bank account you want to fund.',
                  style: GlobalTextStyles.regularGreenText(
                      context: context, fontSize: 14),
                ),
              ),
              const SizedBox(height: 70),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      color: GlobalColors.globalWhite,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20))),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 40),
                          GestureDetector(
                            onTap: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) =>
                                    const AddBankBottomSheet()),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: Row(
                                children: [
                                  Text('Add bank',
                                      style: GlobalTextStyles.regularText(
                                          context: context, fontSize: 16)),
                                  const SizedBox(width: 20),
                                  SvgPicture.asset(
                                      'assets/images/circle_plus_icon.svg')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      state.listOfBanks.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 90),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  SvgPicture.asset('assets/images/no_card.svg',
                                      height: 70),
                                  const SizedBox(height: 10),
                                  const Text('No account added')
                                ],
                              ),
                            )
                          : MediaQuery.removePadding(
                              context: context,
                              removeLeft: true,
                              child: Flexible(
                                child: ListView.builder(
                                    itemCount: state.listOfBanks.length,
                                    itemBuilder: (context, index) =>
                                        BankAccountItem(
                                            bankDetail:
                                                state.listOfBanks[index])),
                              )),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class BankAccountItem extends StatelessWidget {
  const BankAccountItem({
    Key? key,
    required this.bankDetail,
  }) : super(key: key);

  final BankDetail bankDetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => getItInstance<NavigationServiceImpl>()
          .navigateTo(Routes.withdrawScreen),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: GlobalColors.ashWhiteB.withAlpha(100),
            border: Border.all(color: GlobalColors.ashWhite),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bankDetail.accountName,
              style: GlobalTextStyles.regularMediumW(
                  context: context, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(bankDetail.bank)),
                Text(bankDetail.bankAccountNo),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
