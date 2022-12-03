import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                height: 450,
                child: SvgPicture.asset('assets/images/${widget.imagePath}',
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                FadeIn(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeIn,
                  child: Text(
                    widget.title,
                    style: GlobalTextStyles.blueBoldText(context: context),
                  ),
                ),
                const SizedBox(height: 20),
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
