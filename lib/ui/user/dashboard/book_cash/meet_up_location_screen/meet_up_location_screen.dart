import 'package:cash_xchanger/cubit/book_cash_cubit/book_cash_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/black_back_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_gray_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../dependency/get_it.dart';
import '../../../../../navigation/navigation_service.dart';
import '../../../../../navigation/routes.dart';
import '../book_cash_screen.dart';
import '../connect_vendor/denomination_in_custody_widget.dart';
import '../meet_up_location_bottomsheet.dart';

class MeetUpLocationScreen extends StatelessWidget {
  const MeetUpLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<BookCashCubit>().getBalance();
    return BlocBuilder<BookCashCubit, BookCashState>(
      builder: (context, state) {
        return ValueListenableBuilder(
            valueListenable: meetUpLocation,
            builder: (context, String values, child) {
              return Scaffold(
                backgroundColor: GlobalColors.ashWhiteC,
                body: Column(
                  children: [
                    const BlackBackButtonWidget(text: 'Meetup location'),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: GlobalColors.globalWhite),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order Review',
                                      style: GlobalTextStyles.greenMediumText(
                                          context: context, fontSize: 16),
                                    ),
                                    GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: SvgPicture.asset(
                                            'assets/images/edit_icon.svg',
                                            height: 30))
                                  ],
                                ),
                                const Divider(thickness: 1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Available balance in funds',
                                      style: GlobalTextStyles.regularText(
                                          context: context,
                                          fontSize: 12,
                                          alpha: 100),
                                    ),
                                    state.balance.isEmpty
                                        ? Text(
                                            'N${formatFiguresSeparator(0.0)}',
                                            style:
                                                GlobalTextStyles.regularMediumW(
                                                    context: context,
                                                    fontSize: 18))
                                        : Text(
                                            formatFigures(double.tryParse(
                                                state.balance)!),
                                            style:
                                                GlobalTextStyles.boldGreenText(
                                                    context: context,
                                                    fontSize: 20)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text('Cash request'),
                                Text(
                                  'N${formatFiguresSeparator(double.tryParse(state.amount)!)}',
                                  style: GlobalTextStyles.blueMediumText(
                                      context: context, fontSize: 28),
                                ),
                                const SizedBox(height: 20),
                                Text('Cash Denominations',
                                    style: GlobalTextStyles.regularMediumH(
                                        fontSize: 14)),
                                const SizedBox(height: 10),
                                const DenominationInCustodyWidget(),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) =>
                                    const MeetUpLocationBottomSheet()),
                            child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: GlobalColors.primaryBlue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Enter meetup location',
                                      style:
                                          GlobalTextStyles.regularMediumWhiteH(
                                              context: context),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Tell us where you want your cash delivered',
                                      style: GlobalTextStyles.regularTextWhite(
                                          context: context,
                                          fontSize: 14,
                                          alpha: 100),
                                    )
                                  ],
                                )),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                              color: GlobalColors.globalWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/location_icon.svg'),
                                const SizedBox(width: 15),
                                Text(values,
                                    style: GlobalTextStyles.regularMediumH(
                                        fontSize: 14)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 20),
                        decoration: BoxDecoration(
                          color: GlobalColors.globalWhite,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalGrayButton(
                                buttonText: 'Schedule delivery later',
                                onTap: () => getItInstance<BookCashCubit>()
                                    .scheduleDeliveryLater(
                                        context: context,
                                        bookCashState: state)),
                            const SizedBox(height: 20),
                            GlobalButton(
                                buttonText: 'Continue',
                                isButtonColorGreen: true,
                                onTap: () {
                                  if (meetUpLocation.value.isNotEmpty) {
                                    getItInstance<NavigationServiceImpl>()
                                        .navigateTo(Routes.connectVendorScreen);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Pls add meet up location');
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
