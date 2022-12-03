import 'package:cash_xchanger/cubit/book_cash_cubit/book_cash_cubit.dart';
import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/global_widgets/profile_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency/get_it.dart';
import '../../../../navigation/navigation_service.dart';
import '../../../../navigation/routes.dart';
import '../../../global_widgets/edit_text_widget.dart';
import '../../../shared_ui/navigation_drawer/drawer/navigation_drawer.dart';
import 'cash_type_widget.dart';
import 'money_widget.dart';

final fiftyChecked = ValueNotifier(false);
final oneChecked = ValueNotifier(false);
final twoChecked = ValueNotifier(false);
final fiveChecked = ValueNotifier(false);
final oneKChecked = ValueNotifier(false);
final cashType = ValueNotifier(true);
final switchCards = ValueNotifier(true);
final reveal = ValueNotifier(false);
final meetUpLocation = ValueNotifier('');

class BookCashScreen extends StatelessWidget {
  const BookCashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    final amountController = TextEditingController();
    final fiftyNairaController = TextEditingController();
    final hundredNairaController = TextEditingController();
    final twoHundredNairaController = TextEditingController();
    final fiveHundredNairaController = TextEditingController();
    final oneThousandNairaController = TextEditingController();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const NavigationDrawer(),
          backgroundColor: GlobalColors.ashWhiteB,
          body: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ProfileBarWidget(titleText: 'Request cash'),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text('How much cash do you need?',
                            style: GlobalTextStyles.blueMediumTextB(
                              context: context,
                              fontSize: 16,
                            )),
                        const SizedBox(height: 25),
                        EditTextField(textController: amountController),
                        const SizedBox(height: 10),
                        Text('+0.005% processing fee : N100',
                            style: GlobalTextStyles.greenMediumText(
                              context: context,
                              fontSize: 13,
                            )),
                        const SizedBox(height: 20),
                        Text('What currency denomination do you need?',
                            style: GlobalTextStyles.blueMediumTextB(
                              context: context,
                              fontSize: 14,
                            )),
                        Container(
                          color: GlobalColors.primaryPurpleLight,
                          margin: const EdgeInsets.only(top: 10),
                          padding:
                              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(
                              'You can stack up multiple denominations and cash order!',
                              style: GlobalTextStyles.regularTextPurple(
                                context: context,
                                fontSize: 12,
                              )),
                        ),
                        MoneyWidget(
                            textController: fiftyNairaController,
                            isChecked: fiftyChecked,
                            moneyValue: 50),
                        MoneyWidget(
                            textController: hundredNairaController,
                            isChecked: oneChecked,
                            moneyValue: 100),
                        MoneyWidget(
                            textController: twoHundredNairaController,
                            isChecked: twoChecked,
                            moneyValue: 200),
                        MoneyWidget(
                            textController: fiveHundredNairaController,
                            isChecked: fiveChecked,
                            moneyValue: 500),
                        MoneyWidget(
                            textController: oneThousandNairaController,
                            isChecked: oneKChecked,
                            moneyValue: 1000),
                        const CashTypeWidget(),
                        GlobalButton(
                            buttonText: 'Proceed',
                            isButtonColorGreen: true,
                            horizontalMargin: 30,
                            onTap: () {
                              var fifty =
                                  double.tryParse(fiftyNairaController.text) ??
                                      0;
                              var hund = double.tryParse(
                                      hundredNairaController.text) ??
                                  0;
                              var twoHun = double.tryParse(
                                      twoHundredNairaController.text) ??
                                  0;
                              var fiveHun = double.tryParse(
                                      fiveHundredNairaController.text) ??
                                  0;
                              var oneThou = double.tryParse(
                                      oneThousandNairaController.text) ??
                                  0;
                              var amount =
                                  double.tryParse(amountController.text) ?? 0;
                              var sum =
                                  (fifty + hund + twoHun + fiveHun + oneThou);

                              if (formKey.validate) {
                                if (amount == sum) {
                                  var cashData = {
                                    'meetup_location': meetUpLocation.value,
                                    'cash_type':
                                        cashType.value ? 'stable' : 'mint',
                                    'cash_amount': amount.toString(),
                                    'fifty': fiftyNairaController.text,
                                    'hundred': hundredNairaController.text,
                                    'two_hundred':
                                        twoHundredNairaController.text,
                                    'five_hundred':
                                        fiveHundredNairaController.text,
                                    'one_thousand':
                                        oneThousandNairaController.text,
                                    'balance': state
                                        .transactionBalanceModel!.userBalance,
                                  };
                                  context
                                      .read<BookCashCubit>()
                                      .saveCashDetails(cashData: cashData);
                                  getItInstance<NavigationServiceImpl>()
                                      .navigateTo(Routes.meetUpLocationScreen);
                                } else {
                                  var snackBar = SnackBar(
                                      content: Text(
                                          'Total denomination(N$sum) is not equal '
                                          'to Needed Cash(#$amount)'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            }),
                        const SizedBox(height: 40)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
