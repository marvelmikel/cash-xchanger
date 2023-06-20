import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:user/user.dart';

import 'credit_card_carousel.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key? key, this.paymentType}) : super(key: key);
  final PaymentType? paymentType;
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
                children:  [
                  //   EwalletWidget(),
                widget.paymentType != null ?  const CreditCardCarousel() :
                  const BankCarousel(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum PaymentType { card, bank }
