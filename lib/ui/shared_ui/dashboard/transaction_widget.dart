import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../database/models/transaction_history_and_balance_model/transaction_history_model.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Expanded(
            child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 1.h),
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Latest Transactions',
                              style: GlobalTextStyles.regularMediumW(
                                  context: context, fontSize: 14)),
                          Text('Show more',
                              style: GlobalTextStyles.regularGreenTexMedium(
                                  context: context, fontSize: 14))
                        ],
                      ),
                    ),
                    SizedBox(height: GlobalSizes.globalWidth(context, 0.04)),
                    state.transactionHistory.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(height: 10),
                                  SvgPicture.asset('assets/images/no_card.svg',
                                      height: 70),
                                  const SizedBox(height: 10),
                                  const Text('No recent transactions')
                                ],
                              ),
                            ),
                          )
                        : Flexible(
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                  itemCount: state.transactionHistory.length,
                                  itemBuilder: (context, index) =>
                                      TransactionItem(
                                          transactionHistory:
                                              state.transactionHistory[index])),
                            ),
                          )
                  ],
                )));
      },
    );
  }
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key, required this.transactionHistory})
      : super(key: key);

  final TransactionHistory transactionHistory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
              color: GlobalColors.globalWhite,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              transactionHistory.type == 'book_cash'
                  ? SvgPicture.asset('assets/images/cash_request_loader.svg',
                      height: 40)
                  : transactionHistory.cashType == 'airtime'
                      ? SvgPicture.asset('assets/images/airtime_loader.svg',
                          height: 40)
                      : SvgPicture.asset(
                          'assets/images/balance_top_up_loader.svg',
                          height: 40),
              SizedBox(width: GlobalSizes.globalWidth(context, 0.03)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transactionHistory.type,
                              style: GlobalTextStyles.blueBoldText(
                                  context: context, fontSize: 14)),
                          SizedBox(
                              height: GlobalSizes.globalWidth(context, 0.005)),
                          Text(transactionHistory.dateCreated,
                              style: GlobalTextStyles.regularText(
                                  context: context, fontSize: 11)),
                        ]),
                    Text(
                        formatFigures(
                            double.tryParse(transactionHistory.amount)!),
                        style: GlobalTextStyles.blueMediumText(
                            context: context, fontSize: 16))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
