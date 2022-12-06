import 'package:cash_xchanger/database/models/onboard_screen_model.dart';
import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/navigation/navigation_service.dart';
import 'package:cash_xchanger/navigation/routes.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController pageController = PageController(initialPage: 0);
  int pageCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) => setState(() => pageCount = value),
          children: OnboardScreenModel.listOfOnboardPagesWidgets(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotHeight: 15,
                      dotWidth: 15,
                      expansionFactor: 2,
                      dotColor: GlobalColors.washedWhite,
                      activeDotColor: GlobalColors.materialPrimaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              GlobalButton(
                buttonText: 'Explore CX',
                height: 8,
                onTap: () => getItInstance<NavigationServiceImpl>()
                    .navigateTo(Routes.overViewScreen),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ],
    ));
  }
}
