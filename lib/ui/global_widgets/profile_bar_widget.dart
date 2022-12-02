import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileBarWidget extends StatefulWidget {
  const ProfileBarWidget({Key? key, this.titleText = 'Request cash'})
      : super(key: key);

  final String titleText;

  @override
  State<ProfileBarWidget> createState() => _ProfileBarWidgetState();
}

class _ProfileBarWidgetState extends State<ProfileBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: GlobalSizes.globalHeight(context, 0.12),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              borderRadius: BorderRadius.circular(10),
              child: Icon(
                Icons.menu,
                size: 30,
                color: GlobalColors.primaryGreen,
              ),
            ),
            widget.titleText.isEmpty
                ? SvgPicture.asset(
                    'assets/images/icon_blue.svg',
                    height: 35,
                  )
                : Text(widget.titleText,
                    style: GlobalTextStyles.blueMediumText(
                        context: context, fontSize: 20)),
            profileImage(context: context)
          ],
        ),
      ),
    );
  }
}
