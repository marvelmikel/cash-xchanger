import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/ui/global_widgets/profile_back_button.dart';
import 'package:flutter/material.dart';

import 'bank_carousel.dart';
import 'credit_card_carousel.dart';
import 'e_wallet_widget.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.globalWhite,
      body: Column(
        children: [
          const ProfileBackButtonWidget(
              text: 'Payment methods', isImageVisible: false),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  EwalletWidget(),
                  CreditCardCarousel(),
                  BankCarousel(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
