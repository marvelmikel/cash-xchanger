
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared/shared.dart';


class TransactionsScreen extends ConsumerWidget {
  TransactionsScreen({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context, ref) {
    final navigation = ref.watch(navProvider);
    final profile = ref.watch(profileViewModelProviderV1);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title:  Text('Transaction history',style: GlobalTextStyles.regularMediumH(fontSize: 20)),
            centerTitle: true,
            leading: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () => Navigator.pop(context),
                child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 40,
                    width: 40,
                    child: Icon(Icons.arrow_back_ios,
                        color: GlobalColors.primaryBlack))),
            actions: [
              MenuFiller(
                icon: Icons.menu,
                onClick: () {},
                color: GlobalColors.lightGreen,
                bgColor: Colors.transparent,
                size: 30,
              ),
            ],
          ),
          body: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 1.h),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('',
                          style: GlobalTextStyles.regularMediumW(
                              context: context, fontSize: 14)),
                      Row(
                        children: [
                          MenuFiller(
                            icon: Icons.search,
                            onClick: () {},
                            color: GlobalColors.lightGreen,
                            bgColor: const Color(0xffC0F7C4),
                            size: 30,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          MenuFiller(
                            icon: Icons.filter_alt_outlined,
                            onClick: () {},
                            color: GlobalColors.lightGreen,
                            bgColor: const Color(0xffC0F7C4),
                            size: 30,
                          )
                        ],
                      )
                      // Text('See All',
                      //     style: GlobalTextStyles.regularGreenTexMedium(
                      //         context: context, fontSize: 14))
                    ],
                  ),
                ),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.04)),
                profile.transactionHistory.isEmpty
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
                        itemCount: profile.transactionHistory.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            final data =
                            profile.transactionHistory[index];
                            debugPrint(
                                'this is the transaction History data ${data.toMap()}');
                          },
                          child: TransactionItem(
                              transactionHistory:
                              profile.transactionHistory[index]),
                        )),
                  ),
                )
              ],
            ),
          ),
        );

  }
}
