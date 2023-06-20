import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class OnboardPageItem extends StatefulWidget {
  const OnboardPageItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.bodyText,
  }) : super(key: key);

  final String imagePath, title, bodyText;

  @override
  State<OnboardPageItem> createState() => _OnboardPageItemState();
}

class _OnboardPageItemState extends State<OnboardPageItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeIn,
            child: SizedBox(
                height: 60.h,
                child: SvgPicture.asset('assets/images/${widget.imagePath}',
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                FadeIn(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeIn,
                  child: Text(
                    widget.title,
                    style: GlobalTextStyles.boldText(context: context),
                  ),
                ),
                SizedBox(height: 2.h),
                FadeIn(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeIn,
                  child: Text(
                    widget.bodyText,
                    style: TextStyle(
                      fontSize: GlobalSizes.globalWidth(context, 0.045),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
