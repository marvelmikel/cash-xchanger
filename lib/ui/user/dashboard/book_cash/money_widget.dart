import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'money_edit_text_widget.dart';

class MoneyWidget extends StatelessWidget {
  final TextEditingController textController;
  final int moneyValue;
  final ValueNotifier<bool> isChecked;

  const MoneyWidget({
    Key? key,
    required this.textController,
    required this.moneyValue,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ValueListenableBuilder(
                  valueListenable: isChecked,
                  builder: (context, bool checked, child) {
                    return AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                        padding: const EdgeInsets.all(2),
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: checked
                                ? GlobalColors.purpleBlue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: GlobalColors.purpleBlue.withAlpha(80),
                                width: 2)),
                        child: checked
                            ? SvgPicture.asset('assets/images/tick_icon.svg',
                                height: 15)
                            : const SizedBox.shrink());
                  }),
              const SizedBox(width: 20),
              Container(
                  padding: const EdgeInsets.only(top: 14, bottom: 14, left: 14),
                  width: 120,
                  decoration: BoxDecoration(
                      color: GlobalColors.materialPrimaryColor.withAlpha(40),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('N$moneyValue notes',
                      style: GlobalTextStyles.greenMediumText(
                          context: context, fontSize: 15)))
            ],
          ),
          const SizedBox(width: 20),
          MoneyEditTextField(
              textController: textController,
              denomination: moneyValue,
              isChecked: isChecked)
        ],
      ),
    );
  }
}
