import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../overview_screen/user_cash_widget.dart';

class PasswordStrenght extends StatefulWidget {
  bool containUppercase;
  bool containLowercase;
  bool containDigit;
  bool has8Characters;
  bool hasSpecialCharacter;
  PasswordStrenght(
      {Key? key,
      required this.containLowercase,
      required this.containDigit,
      required this.hasSpecialCharacter,
      required this.has8Characters,
      required this.containUppercase})
      : super(key: key);

  @override
  State<PasswordStrenght> createState() => _PasswordStrenghtState();
}

class _PasswordStrenghtState extends State<PasswordStrenght> {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-5.0, 0.0),
      child: Wrap(
        runSpacing: -17,
        spacing: -20,
        children: [
          chipContent(title: 'Uppercase', isActive: widget.containUppercase),
          chipContent(title: 'Lowercase', isActive: widget.containLowercase),
          chipContent(title: '1 Digit', isActive: widget.containDigit),
          chipContent(title: '11 Characters', isActive: widget.has8Characters),
          chipContent(
              title: '1 Special Character',
              isActive: widget.hasSpecialCharacter),
        ],
      ),
    );
  }

  Widget chipContent({
    required String title,
    required bool isActive,
  }) =>
      ValueListenableBuilder(
          valueListenable: userType,
          builder: (context, value, child) {
            return Transform.scale(
              scale: 0.72,
              child: FilterChip(
                label: Text(
                  title,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: isActive
                        ? GlobalColors.washedWhite
                        : const Color(0xff717171),
                  ),
                ),
                padding: const EdgeInsets.only(right: 1, left: 1, bottom: 1),
                labelPadding: const EdgeInsets.only(right: 8, left: 0),
                avatar: Padding(
                  padding: const EdgeInsets.only(top: 2, left: 1),
                  child: Icon(
                    Icons.check_rounded,
                    size: 8.sp,
                    color: isActive
                        ? GlobalColors.washedWhite
                        : const Color(0xff717171),
                  ),
                ),
                showCheckmark: false,
                shape: const StadiumBorder(
                    side: BorderSide(
                  width: 0,
                  color: Colors.transparent,
                )),
                selected: isActive,
                selectedColor: (value.toString() != 'user'
                    ? GlobalColors.blueColor
                    : GlobalColors.primaryGreen),
                backgroundColor: GlobalColors.purpleBlue.withOpacity(0.1),
                pressElevation: 0,
                selectedShadowColor: Colors.transparent,
                onSelected: (bool value) {},
              ),
            );
          });


} // purpleBlue
