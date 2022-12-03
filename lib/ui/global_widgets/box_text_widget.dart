import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoxEditText extends StatelessWidget {
  const BoxEditText(
      {Key? key,
      required this.fieldName,
      required this.keyBoardType,
      required this.hint})
      : super(key: key);

  final String fieldName, hint;
  final TextInputType keyBoardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
          color: GlobalColors.ashWhite,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5),
            child: Text(fieldName,
                style: GlobalTextStyles.regularText(
                    context: context, fontSize: 12)),
          ),
          TextFormField(
            enabled: false,
            keyboardType: keyBoardType,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            style:
                GlobalTextStyles.blueMediumText(context: context, fontSize: 18),
            decoration: InputDecoration(
              fillColor: GlobalColors.ashWhite,
              filled: true,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black.withBlue(60)),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'This input is empty';
              } else if (keyBoardType == TextInputType.emailAddress) {
                bool isValid = isValidEmail(context, value);
                if (!isValid) {
                  return 'Not a valid email';
                }
              } else if (keyBoardType == TextInputType.name) {
                if (value.length < 3) {
                  return 'Not a valid name';
                }
              } else {
                return null;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
