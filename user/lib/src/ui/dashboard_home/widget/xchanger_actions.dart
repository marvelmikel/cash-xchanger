
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sizer/sizer.dart';


class XchangerActions extends StatelessWidget {
  const XchangerActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageWidget(
            onTap: (){},
            imagePath: 'book_cash_icon.svg',
            imageTitle: 'Book cash',
          ),
          ImageWidget(
            onTap: () {

              // getItInstance<NavigationServiceImpl>()
              //   .navigateTo(Routes.withdrawFundsScreen)

  },
            imagePath: 'withdraw_icon.svg',
            imageTitle: 'Withdraw',
          ),
          ImageWidget(
            onTap: () {

                // getItInstance<NavigationServiceImpl>()
                // .navigateTo(Routes.fundWalletScreen)

    },
            imagePath: 'top_up_icon.svg',
            imageTitle: 'Top up',
          ),
          ImageWidget(
            onTap: () {
              // if (getItInstance<BookCashCubit>()
              //         .tempDataBaseImpl
              //         .getUnfinishedCashOrder()
              //         .isNotEmpty ||
              //     getItInstance<BookCashCubit>()
              //         .tempDataBaseImpl
              //         .getUnfinishedTransaction()
              //         .isNotEmpty) {
              //   getItInstance<BookCashCubit>().checkAvailabilityAndNavigate();
              // } else {
              //   Fluttertoast.showToast(msg: 'No pending transaction yet');
              // }
            },
            imagePath: 'airtime_icon.svg',
            imageTitle: 'Pendings',
          ),
        ],
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.imagePath,
    required this.imageTitle,
    required this.onTap,
  }) : super(key: key);

  final String imagePath, imageTitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset('assets/images/$imagePath', height: 22),
            decoration: BoxDecoration(
              color: GlobalColors.primaryGreen.withAlpha(70),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            imageTitle,
            style: GlobalTextStyles.blueMediumText(
              context: context,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
