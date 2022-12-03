import 'dart:math';

import 'package:cash_xchanger/cubit/nav_bar_cubit/nav_drawer_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../database/models/cards_model/card_model.dart';
import '../../../../dependency/get_it.dart';
import '../../../../navigation/navigation_service.dart';
import '../../../../navigation/routes.dart';

class CreditCardCarousel extends StatefulWidget {
  const CreditCardCarousel({
    Key? key,
  }) : super(key: key);

  @override
  State<CreditCardCarousel> createState() => _CreditCardCarouselState();
}

class _CreditCardCarouselState extends State<CreditCardCarousel> {
  @override
  void initState() {
    context.read<NavDrawerCubit>().getCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavDrawerCubit, NavDrawerState>(
      builder: (context, state) {
        PageController pageController =
            PageController(initialPage: 0, viewportFraction: 0.9);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => getItInstance<NavigationServiceImpl>()
                        .navigateTo(Routes.addCardScreen),
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
              child: state.listOfCards.isEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 10),
                        SvgPicture.asset('assets/images/no_card.svg',
                            height: 70),
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
                        children: _listOfCardWidgets(state.listOfCards),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

List<Widget> _listOfCardWidgets(List<CardDetail> cardList) {
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
  }) : super(key: key);

  final Color? color;
  final String cardName, cardNumber, expiryDate;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Baseline(
                baseline: 40,
                baselineType: TextBaseline.alphabetic,
                child: Row(
                  children: [
                    Text(
                      '****',
                      style: TextStyle(
                          fontFamily: 'nunito',
                          letterSpacing: 4,
                          color: GlobalColors.globalWhite,
                          fontSize: 18),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      cardNumber.substring(0, 4),
                      style: GlobalTextStyles.regularTextWhite(
                          context: context, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset('assets/images/mastercard_icon.svg')
            ],
          ),
          const SizedBox(height: 40),
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
