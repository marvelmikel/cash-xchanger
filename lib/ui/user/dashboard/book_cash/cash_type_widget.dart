import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';

import 'book_cash_screen.dart';

class CashTypeWidget extends StatelessWidget {
  const CashTypeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      decoration: BoxDecoration(
          border: Border.all(
              color: GlobalColors.primaryBlue.withAlpha(20), width: 2),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: const [
          ButtonWidget(cashTypes: 'Stale cash', positionValue: true),
          SizedBox(width: 15),
          ButtonWidget(cashTypes: 'Mint cash', positionValue: false),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.cashTypes,
    required this.positionValue,
  }) : super(key: key);

  final String cashTypes;
  final bool positionValue;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: cashType,
        builder: (context, value, child) {
          return Expanded(
            child: GestureDetector(
              onTap: () => cashType.value = positionValue,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                    color: value == positionValue
                        ? GlobalColors.primaryBlue
                        : GlobalColors.primaryBlue.withAlpha(20),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  cashTypes,
                  style: value == positionValue
                      ? GlobalTextStyles.regularTextWhite(context: context)
                      : GlobalTextStyles.regularText(context: context),
                ),
              ),
            ),
          );
        });
  }
}
