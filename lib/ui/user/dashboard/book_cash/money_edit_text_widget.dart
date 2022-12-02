import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyEditTextField extends StatelessWidget {
  final TextEditingController textController;
  final ValueNotifier<bool> isChecked;
  final int denomination;

  const MoneyEditTextField(
      {Key? key,
      required this.textController,
      required this.isChecked,
      required this.denomination})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: textController,
        onChanged: (text) =>
            text.isNotEmpty ? isChecked.value = true : isChecked.value = false,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        style: GlobalTextStyles.blueMediumText(context: context, fontSize: 16),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          fillColor: GlobalColors.ashWhiteB,
          hintText: 'Enter amount',
          hintStyle: GlobalTextStyles.regularText(context: context, alpha: 50),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: GlobalColors.ashWhiteC)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 0.5)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: GlobalColors.primaryGreen),
          ),
        ),
        validator: (value) {
          var convertedValue = int.tryParse(value ?? '0');
          if (value!.isEmpty) {
            return 'This input is empty';
          } else if (convertedValue! <= denomination) {
            return 'Value can\'t be $convertedValue';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
