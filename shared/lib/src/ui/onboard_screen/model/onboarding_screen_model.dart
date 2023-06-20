import 'package:flutter/material.dart';

import '../onboard_page_item.dart';

class OnboardScreenModel {
  String imagePath, title, bodyText;

  OnboardScreenModel({
    required this.imagePath,
    required this.title,
    required this.bodyText,
  });

  static List<OnboardScreenModel> onboardScreens = [
    OnboardScreenModel(
        imagePath: 'handy_image.svg',
        title: 'Easy cash delivery in a few taps.',
        bodyText: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
    OnboardScreenModel(
        imagePath: 'chart_image.svg',
        title: 'Conscious Control.',
        bodyText: 'keep track of your money requests and create goals.'),
    OnboardScreenModel(
        imagePath: 'money_people_image.svg',
        title: 'Money transfers for free.',
        bodyText: 'keep track of your money requests and create goals.'),
  ];

  static List<Widget> listOfOnboardPagesWidgets() {
    List<Widget> _listOfOnboardPages = [
      OnboardPageItem(
          imagePath: onboardScreens[0].imagePath,
          title: onboardScreens[0].title,
          bodyText: onboardScreens[0].bodyText),
      OnboardPageItem(
          imagePath: onboardScreens[1].imagePath,
          title: onboardScreens[1].title,
          bodyText: onboardScreens[1].bodyText),
      OnboardPageItem(
          imagePath: onboardScreens[2].imagePath,
          title: onboardScreens[2].title,
          bodyText: onboardScreens[2].bodyText),
    ];
    return _listOfOnboardPages;
  }
}
