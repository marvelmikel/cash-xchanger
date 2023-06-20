import 'dart:math';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared/shared.dart';
import 'package:sizer/sizer.dart';

class CreditCardCarousel extends ConsumerStatefulWidget {
  const CreditCardCarousel({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CreditCardCarousel> createState() => _CreditCardCarouselState();
}

class _CreditCardCarouselState extends ConsumerState<CreditCardCarousel> {
  @override
  void initState() {
    // context.read<NavDrawerCubit>().getCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: 0, viewportFraction: 0.9);
    final navigation = ref.watch(navProvider);
    final profile = ref.watch(profileViewModelProviderV1);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => navigation.navigateTo(Routes.addCardScreen),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Row(
                    children: [
                      Text('Credit cards',
                          style: GlobalTextStyles.regularText(
                              context: context, fontSize: 18)),
                      const SizedBox(width: 20),
                      SvgPicture.asset('assets/images/circle_plus_icon.svg')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 190,
          child: profile.currentUser.cards!.isEmpty
              ? Column(
                  children: [
                    const SizedBox(height: 10),
                    SvgPicture.asset('assets/images/no_card.svg', height: 70),
                    const SizedBox(height: 10),
                    const Text('No cards added')
                  ],
                )
              : MediaQuery.removePadding(
                  context: context,
                  removeLeft: true,
                  child: PageView(
                    controller: pageController,
                    pageSnapping: true,
                    scrollDirection: Axis.horizontal,
                    children: _listOfCardWidgets(profile.currentUser.cards!),
                  ),
                ),
        ),
      ],
    );
  }
}

List<Widget> _listOfCardWidgets(List<Cards> cardList) {
  List<Widget> _listOfCreditCards = [];
  List<Color> colorList = [
    GlobalColors.primaryBlue,
    GlobalColors.deepPurple,
  ];

  for (int i = 0; i < cardList.length; i++) {
    _listOfCreditCards.add(
      _CardWidget(
          color: colorList[Random().nextInt(2)],
          cardNumber: cardList[i].cardNumber,
          cardName: cardList[i].cardName,
          isDefault: cardList[i].isDefault,
          expiryDate: cardList[i].expiry),
    );
  }

  return _listOfCreditCards;
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    Key? key,
    required this.color,
    required this.cardName,
    required this.cardNumber,
    required this.expiryDate,
    required this.isDefault,
  }) : super(key: key);

  final Color? color;
  final String cardName, cardNumber, expiryDate;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      margin: const EdgeInsets.only(right: 10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isDefault
              ? Container(
                  width: 14.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                      color: GlobalColors.washedWhite,
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                    child: Text('Default',
                        style: GlobalTextStyles.regularMediumW(
                          context: context,
                          fontSize: 8.sp,
                        )),
                  ),
                )
              : SizedBox(
                  width: 14.w,
                  height: 2.h,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Baseline(
                baseline: 20,
                baselineType: TextBaseline.alphabetic,
                child: Row(
                  children: [
                    Text(
                      context.tokenFormatter(cardNumber),
                      style: GlobalTextStyles.regularTextWhite(
                          context: context, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset('assets/images/mastercard_icon.svg')
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Card Holder Name',
                      style: GlobalTextStyles.regularTextWhite(
                          context: context, fontSize: 14, alpha: 100)),
                  Text(cardName,
                      style:
                          GlobalTextStyles.regularTextWhite(context: context)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Expiry Date',
                      style: GlobalTextStyles.regularTextWhite(
                          context: context, fontSize: 14, alpha: 100)),
                  Text(expiryDate,
                      style:
                          GlobalTextStyles.regularTextWhite(context: context)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
