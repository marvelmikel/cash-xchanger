import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared/shared.dart';
import 'package:user/src/ui/cash_request/cash_request.dart';
import 'package:user/src/ui/cash_request/widgets/meet_up_location_bottom_sheet.dart';

import '../../data/model/connect_parrms.dart';
import '../dashboard_home/widget/dashboard_vm.dart';

class MeetUpLocationScreen extends ConsumerWidget {
  const MeetUpLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(cashRequstVM);
    final navigation = ref.watch(navProvider);
    final userDash = ref.watch(userDashVM);
              return Scaffold(
                backgroundColor: GlobalColors.ashWhiteB,
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
                                const SizedBox(height: 10),

                                const Text('Cash request'),
                                Text(
                                  'N${formatFiguresSeparator(double.parse(userDash.cost))}',
                                  style: GlobalTextStyles.blueMediumText(
                                      context: context, fontSize: 28),
                                ),
                                const SizedBox(height: 20),
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
                                  color: GlobalColors.globalWhite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Enter meetup location',
                                      style: GlobalTextStyles.regularMediumH(),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Tell us where you want your cash delivered',
                                      style: GlobalTextStyles.regularText(
                                        context: context,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    const Divider(
                                      thickness: 1,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: GlobalColors.globalWhite,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/location_icon.svg'),
                                          const SizedBox(width: 15),
                                          SizedBox(
                                            width: 300,
                                            child: Text(state.meetUpLocation,

                                                style: GlobalTextStyles
                                                    .regularMediumH(
                                                    fontSize: 14)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 20),
                        decoration: BoxDecoration(
                          color: GlobalColors.ashWhiteB,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // GlobalGrayButton(
                            //     buttonText: 'Schedule delivery later',
                            //     onTap: () => getItInstance<BookCashCubit>()
                            //         .scheduleDeliveryLater(
                            //             context: context,
                            //             bookCashState: state)),
                            const SizedBox(height: 20),
                            GlobalButton(
                                title: 'Request Cash',

                                onPressed: () {
                                  if (state.meetUpLocation.isNotEmpty) {
                                    navigation
                                        .navigateTo(Routes.connectVendorScreen, arguments: ConnectParams(amount: state.amount, location:  state.meetUpLocation));
                                  } else {

                                    alert(description: 'Pls add meet up location');

                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );


  }
}