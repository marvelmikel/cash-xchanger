import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';

class BlackBackButtonWidget extends StatelessWidget {
  const BlackBackButtonWidget({
    Key? key,
    required this.text
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalColors.globalWhite,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () => Navigator.pop(context),
                child: Container(
                    margin: EdgeInsets.only(left: 5),
                    height: 40,
                    width: 40,
                    child: Icon(Icons.arrow_back_ios,
                        color: GlobalColors.primaryBlack))),
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text( text,
                  style: GlobalTextStyles.regularMediumW(
                      context: context, fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
