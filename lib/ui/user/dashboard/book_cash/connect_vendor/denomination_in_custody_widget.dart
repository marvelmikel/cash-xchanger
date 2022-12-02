import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubit/book_cash_cubit/book_cash_cubit.dart';

class DenominationInCustodyWidget extends StatelessWidget {
  const DenominationInCustodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCashCubit, BookCashState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DenominationItem(
                  noteCurrency: 'N50 notes', noteValue: state.fiftyNaira),
              const SizedBox(width: 15),
              DenominationItem(
                  noteCurrency: 'N100 notes', noteValue: state.hundredNaira),
              const SizedBox(width: 15),
              DenominationItem(
                  noteCurrency: 'N200 notes', noteValue: state.twoHundredNaira),
              const SizedBox(width: 15),
              DenominationItem(
                  noteCurrency: 'N500 notes',
                  noteValue: state.fiveHundredNaira),
              const SizedBox(width: 15),
              DenominationItem(
                  noteCurrency: 'N1000 notes',
                  noteValue: state.oneThousandNaira),
            ],
          ),
        );
      },
    );
  }
}

class DenominationItem extends StatelessWidget {
  const DenominationItem({
    Key? key,
    required this.noteValue,
    required this.noteCurrency,
  }) : super(key: key);

  final String noteCurrency, noteValue;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: noteValue.isEmpty ? false : true,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
            decoration: BoxDecoration(
              color: GlobalColors.purpleBlue.withAlpha(50),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              noteCurrency,
              style: GlobalTextStyles.regularMediumH(),
            ),
          ),
          const SizedBox(height: 5),
          DenominationValue(moneyWorth: noteValue),
        ],
      ),
    );
  }
}

class DenominationValue extends StatelessWidget {
  const DenominationValue({
    Key? key,
    required this.moneyWorth,
  }) : super(key: key);

  final String moneyWorth;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Text(moneyWorth.isEmpty ? '' : 'N$moneyWorth worth',
          style: GlobalTextStyles.regularText(
              context: context, fontSize: 14, alpha: 110)),
    );
  }
}
