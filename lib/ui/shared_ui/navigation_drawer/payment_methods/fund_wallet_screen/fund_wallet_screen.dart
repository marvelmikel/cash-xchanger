import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/back_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubit/payment_cubit/payment_cubit.dart';
import '../../../../global_widgets/edit_text_widget.dart';
import 'fund_wallet_button_widget.dart';
import 'fund_wallet_keypad_buttons.dart';

class FundWalletScreen extends StatelessWidget {
  const FundWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amountController = TextEditingController();
    GlobalKey<FormState> amountKey = GlobalKey();

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
                    const BackButtonWidget(backButtonText: 'Fund wallet'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Available balance in funds:',
                          style: GlobalTextStyles.regularTextWashedWhite(
                              context: context, fontSize: 14),
                        ),
                        state.transactionBalanceModel!.userBalance.isEmpty
                            ? Text(
                                ' N 0.00',
                                style: GlobalTextStyles.regularTextWhite(
                                    context: context),
                              )
                            : Text(
                                ' ${formatFigures(double.tryParse(state.transactionBalanceModel!.userBalance)!)}',
                                style: GlobalTextStyles.regularTextWhite(
                                    context: context),
                              )
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
                                onTap: () => context.read<PaymentCubit>().topUp(
                                    amount: amountController.text,
                                    context: context))
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
