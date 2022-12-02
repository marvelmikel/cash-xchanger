import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavMenuItem extends StatelessWidget {
  const NavMenuItem({
    Key? key,
    required this.menuTitle,
    required this.menuSubTitle,
    required this.menuImage,
    required this.onTap,
  }) : super(key: key);

  final String menuTitle, menuSubTitle, menuImage;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/$menuImage', height: 25),
                SizedBox(width: GlobalSizes.globalWidth(context, 0.05)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menuTitle,
                      style: GlobalTextStyles.regularTextWhite(
                          context: context),
                    ),
                    Text(
                      menuSubTitle,
                      style: GlobalTextStyles.regularTextWashedWhite(
                          context: context, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: GlobalSizes.globalHeight(context, 0.025)),
            Divider(
              height: 0.1,
              color: GlobalColors.washedWhite.withAlpha(100),
            )
          ],
        ),
      ),
    );
  }
}
