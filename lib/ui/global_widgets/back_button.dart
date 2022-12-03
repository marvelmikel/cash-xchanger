import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key? key,
    this.backButtonText = 'Account info'
  }) : super(key: key);

  final String backButtonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => Navigator.pop(context),
              child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  height: 40,
                  width: 40,
                  child: Icon(Icons.arrow_back_ios,
                      color: GlobalColors.globalWhite))),
          const SizedBox(width: 30),
          Text(
            backButtonText,
            style: GlobalTextStyles.regularTextWhite(
                context: context, fontSize: 24),
          ),
        ],
      ),
    );
  }
}
