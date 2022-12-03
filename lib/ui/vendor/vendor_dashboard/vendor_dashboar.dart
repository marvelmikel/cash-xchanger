import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/shared_ui/dashboard/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared_ui/navigation_drawer/drawer/navigation_drawer.dart';
import 'switch_button_widget.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({Key? key}) : super(key: key);

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  @override
  void initState() {
    context.read<ProfileCubit>().getProfileDetails();
    context.read<ProfileCubit>().getTransactionHistory(context: context);
    context.read<ProfileCubit>().vendorRating(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const NavigationDrawer(),
          floatingActionButton: GestureDetector(
            onTap: () {
              // if (GlobalBoxes.getTempCashModel().isNotEmpty) {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => RequestCashScreen(
              //                 latitude: double.tryParse(
              //                     GlobalBoxes.getTempCashModel()
              //                         .get('tempCashModel')!
              //                         .vendorLat)!,
              //                 longitude: double.tryParse(
              //                     GlobalBoxes.getTempCashModel()
              //                         .get('tempCashModel')!
              //                         .vendorLong)!,
              //               )));
              // } else {
              //   Fluttertoast.showToast(msg: 'No pending transaction yet');
              // }
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              child: SvgPicture.asset('assets/images/airtime_icon.svg',
                  height: 22, color: GlobalColors.globalWhite),
              decoration: BoxDecoration(
                color: GlobalColors.primaryGreen,
                shape: BoxShape.circle,
              ),
            ),
          ),
          body: Column(
            children: [
              const VendorTabBar(),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: GlobalColors.globalWhite,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Balance'),
                            state.transactionBalanceModel == null
                                ? Text('N0.00',
                                    style: GlobalTextStyles.blueBoldText(
                                        context: context, fontSize: 18))
                                : Text(
                                    formatFigures(double.tryParse(state
                                        .transactionBalanceModel!
                                        .userBalance)!),
                                    style: GlobalTextStyles.blueBoldText(
                                        context: context, fontSize: 18))
                          ],
                        ),
                        profileImage(context: context)
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: GlobalColors.primaryBlue,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(
                                  'assets/images/accepted_icon.svg'),
                              const SizedBox(height: 10),
                              Text(
                                  state.vendorRatingsModel != null
                                      ? '${state.vendorRatingsModel!.percentageCompletion.round().toString()}%'
                                      : '0%',
                                  style: GlobalTextStyles.regularMediumWhiteH(
                                      context: context)),
                              Text('Accepted',
                                  style: GlobalTextStyles.regularTextWhite(
                                      context: context, alpha: 140))
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset(
                                  'assets/images/star_rating_icon.svg'),
                              const SizedBox(height: 10),
                              Text(
                                  state.vendorRatingsModel != null
                                      ? '${state.vendorRatingsModel!.averageRating.round().toString()}%'
                                      : '0%',
                                  style: GlobalTextStyles.regularMediumWhiteH(
                                      context: context)),
                              Text('Rating',
                                  style: GlobalTextStyles.regularTextWhite(
                                      context: context, alpha: 140))
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset('assets/images/cancel_icon.svg'),
                              const SizedBox(height: 10),
                              Text(
                                  state.vendorRatingsModel != null
                                      ? '${state.vendorRatingsModel!.percentageRejected.round().toString()}%'
                                      : '0%',
                                  style: GlobalTextStyles.regularMediumWhiteH(
                                      context: context)),
                              Text('Cancelled',
                                  style: GlobalTextStyles.regularTextWhite(
                                      context: context, alpha: 140))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const TransactionWidget()
            ],
          ),
        );
      },
    );
  }
}

class VendorTabBar extends StatelessWidget {
  const VendorTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: GlobalSizes.globalHeight(context, 0.12),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              borderRadius: BorderRadius.circular(10),
              child: Icon(
                Icons.menu,
                size: 30,
                color: GlobalColors.primaryGreen,
              ),
            ),
            const SizedBox(width: 90),
            const SwitchButtonWidget()
          ],
        ),
      ),
    );
  }
}
