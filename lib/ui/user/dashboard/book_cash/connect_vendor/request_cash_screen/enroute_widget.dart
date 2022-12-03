import 'dart:convert';

import 'package:cash_xchanger/cubit/book_cash_cubit/book_cash_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/helper_screens/confirm_delivery_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../global_widgets/global_button.dart';
import '../../book_cash_screen.dart';
import '../denomination_in_custody_widget.dart';

class EnRouteWidget extends StatefulWidget {
  const EnRouteWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<EnRouteWidget> createState() => _EnRouteWidgetState();
}

class _EnRouteWidgetState extends State<EnRouteWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCashCubit, BookCashState>(builder: (context, state) {

      return ValueListenableBuilder(
          valueListenable: reveal,
          builder: (context, bool hideCard, child) {
            return Hero(
              tag: 'reveal',
              child: Visibility(
                visible: hideCard ? false : true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              offset: const Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: GlobalColors.globalWhite),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('On his way to you now',
                              style: GlobalTextStyles.regularMediumH(
                                  fontSize: 14)),
                          GestureDetector(
                            onTap: () => reveal.value = true,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: GlobalColors.primaryBlue),
                              child: SvgPicture.asset(
                                'assets/images/money_bag_icon_no_background.svg',
                                height: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 30),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              offset: const Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: GlobalColors.globalWhite),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 20,
                                          backgroundColor: GlobalColors.primaryGreen,
                                          child: ClipOval(
                                            child: Image.memory(
                                              base64Decode(state.tempCashModel!
                                                  .nearestVendors.profileImage),
                                              fit: BoxFit.cover,
                                              height: 50,
                                              width: 50,
                                            ),
                                          )),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              state.tempCashModel!
                                                  .nearestVendors.vendorName,
                                              style: GlobalTextStyles
                                                  .regularMediumH()),

                                          Text(
                                              '${state.tempCashModel!.nearestVendors.cashAvailable} cash vendor',
                                              style: GlobalTextStyles
                                                  .regularGreenText(
                                                      context: context,
                                                      fontSize: 14,
                                                      alpha: 255)),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Cash request'),
                                          Text(
                                            'N${formatFiguresSeparator(state.tempCashModel!.nearestVendors.cashSummary.cashAmount.toDouble())}',
                                            style: GlobalTextStyles
                                                .blueMediumTextB(
                                                    context: context),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      final Uri launchUri = Uri(
                                        scheme: 'tel',
                                        path: state.tempCashModel!
                                            .nearestVendors.phoneNumber,
                                      );
                                      launchUrl(launchUri);
                                    },
                                    child: SvgPicture.asset(
                                        'assets/images/call_icon.svg',
                                        height: 40),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      final Uri launchUri = Uri(
                                        scheme: 'tel',
                                        path: state.tempCashModel!
                                            .nearestVendors.phoneNumber,
                                      );
                                      launchUrl(launchUri);
                                    },
                                    child: SvgPicture.asset(
                                        'assets/images/message_icon.svg',
                                        height: 40),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 10),
                          const Text('Denominations in custody'),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                DenominationItem(
                                    noteCurrency: 'N50 notes',
                                    noteValue: state
                                        .tempCashModel!
                                        .nearestVendors
                                        .cashSummary
                                        .denominations
                                        .fifty
                                        .toString()),
                                const SizedBox(width: 15),
                                DenominationItem(
                                    noteCurrency: 'N100 notes',
                                    noteValue: state
                                        .tempCashModel!
                                        .nearestVendors
                                        .cashSummary
                                        .denominations
                                        .hundred
                                        .toString()),
                                const SizedBox(width: 15),
                                DenominationItem(
                                    noteCurrency: 'N200 notes',
                                    noteValue: state
                                        .tempCashModel!
                                        .nearestVendors
                                        .cashSummary
                                        .denominations
                                        .twoHundred
                                        .toString()),
                                const SizedBox(width: 15),
                                DenominationItem(
                                    noteCurrency: 'N500 notes',
                                    noteValue: state
                                        .tempCashModel!
                                        .nearestVendors
                                        .cashSummary
                                        .denominations
                                        .fiveHundred
                                        .toString()),
                                const SizedBox(width: 15),
                                DenominationItem(
                                    noteCurrency: 'N1000 notes',
                                    noteValue: state
                                        .tempCashModel!
                                        .nearestVendors
                                        .cashSummary
                                        .denominations
                                        .oneThousand
                                        .toString()),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/images/location_icon.svg'),
                              const SizedBox(width: 10),
                              Text(
                                  state.tempCashModel!.nearestVendors
                                      .meetupLocation,
                                  style: GlobalTextStyles.regularMediumH(
                                      fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 30),
                          GlobalButton(
                            buttonText: 'Cash received? End order',
                            isButtonColorGreen: true,
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return const ConfirmDeliveryDialog();
                                }),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => context
                                .read<BookCashCubit>()
                                .cancelBooking(context: context),
                            child: SizedBox(
                              height: 20,
                              child: Center(
                                child: Text('Cancel order',
                                    style: GlobalTextStyles.regularMediumH(
                                        fontSize: 14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }
}
