import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../ui.dart';
import 'model/onboarding_screen_model.dart';

class OnboardScreen extends ConsumerStatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends ConsumerState<OnboardScreen> {
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
                      activeDotColor: GlobalColors.primaryGreen,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              GlobalButton(
                title: 'Explore CashX',

                height: 8,
                onPressed: () => ref.read(navProvider).navigateTo(Routes.overViewScreen)

                   // context.go(Routes.overViewScreen),

                // getItInstance<NavigationServiceImpl>()
                // .navigateTo(Routes.overViewScreen),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ],
    ));
  }
}
