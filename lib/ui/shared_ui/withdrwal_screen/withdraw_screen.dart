import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/back_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/profile_cubit/profile_cubit.dart';
import '../../../dependency/get_it.dart';
import '../../../helpers/helpers.dart';
import '../../../navigation/navigation_service.dart';
import '../../../navigation/routes.dart';
import '../../global_widgets/edit_text_widget.dart';
import '../navigation_drawer/payment_methods/fund_wallet_screen/fund_wallet_button_widget.dart';
import '../navigation_drawer/payment_methods/fund_wallet_screen/fund_wallet_keypad_buttons.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final amountController = TextEditingController();
  GlobalKey<FormState> amountKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return ValueListenableBuilder(
            valueListenable: keypadEquation,
            builder: (context, String totalAmount, _) {
              amountController.text = totalAmount;
              return Scaffold(
                backgroundColor: GlobalColors.primaryBlue,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BackButtonWidget(backButtonText: 'Enter Amount'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Available balance in funds: ',
                          style: GlobalTextStyles.regularGreenText(
                              context: context, fontSize: 14),
                        ),
                        state.transactionBalanceModel == null
                            ? Text(' N 0.00',
                                style: GlobalTextStyles.regularTextWhite(
                                    context: context))
                            : Text(
                                formatFigures(double.tryParse(state
                                    .transactionBalanceModel!.userBalance)!),
                                style: GlobalTextStyles.regularTextWhite(
                                    context: context))
                      ],
                    ),
                    const SizedBox(height: 70),
                    Form(
                      key: amountKey,
                      child: EditTextField(
                          textController: amountController, enabled: false),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      child: Divider(
                          thickness: 1.5,
                          color: GlobalColors.washedWhite.withAlpha(20)),
                    ),
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
                            FundWalletKeypadButtons(
                                textController: amountController),
                            const SizedBox(height: 40),
                            GlobalButton(
                                buttonText: 'Next',
                                isButtonColorGreen: true,
                                onTap: () =>
                                    getItInstance<NavigationServiceImpl>()
                                        .navigateTo(Routes.enterPinScreen,
                                            arguments: totalAmount))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}
