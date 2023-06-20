import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import 'enter_pin_button_widget.dart';

class PinTextField extends StatelessWidget {
  const PinTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: inputText,
        builder: (context, TextEditingController textValue, child) {
          return Center(
            child: PinCodeTextField(
              autoDisposeControllers: false,
              appContext: context,
              enablePinAutofill: true,
              controller: textValue,
              length: 5,
              obscureText: true,
              autoDismissKeyboard: true,
              blinkWhenObscuring: true,
              keyboardType: TextInputType.number,
              obscuringCharacter: '*',
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textStyle: GlobalTextStyles.purpleBoldText(context: context),
              animationDuration: const Duration(milliseconds: 300),
              animationType: AnimationType.fade,
              autoFocus: false,
              cursorColor: GlobalColors.deepPurple,
              onChanged: (text) {
                debugPrint('this is the pin value $text');
              },
              pinTheme: PinTheme(
              //  fieldOuterPadding: EdgeInsets.symmetric(horizontal: 1.w),
                shape: PinCodeFieldShape.circle,
                borderRadius: BorderRadius.circular(8.0),
                fieldWidth: 6.h,
                fieldHeight: 6.h,
                borderWidth: 1,
                activeColor: GlobalColors.primaryBlack.withAlpha(50),
                activeFillColor: GlobalColors.deepPurple,
                inactiveColor: GlobalColors.primaryBlack.withAlpha(50),
                inactiveFillColor: GlobalColors.primaryBlack.withAlpha(50),
                selectedColor: GlobalColors.deepPurple,
                selectedFillColor: GlobalColors.deepPurple,
              ),
            ),
          );
          // return Padding(
          //   padding: EdgeInsets.only(top: 5.h),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       PinItem(pinText: textValue.isNotEmpty ? '*' : ''),
          //       PinItem(pinText: textValue.length > 1 ? '*' : ''),
          //       PinItem(pinText: textValue.length > 2 ? '*' : ''),
          //       PinItem(pinText: textValue.length > 3 ? '*' : ''),
          //     ],
          //   ),
          // );
        });
  }
}

class PinItem extends StatelessWidget {
  const PinItem({Key? key, required this.pinText}) : super(key: key);

  final String pinText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.h,
      height: 8.h,
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: pinText.isNotEmpty
                  ? GlobalColors.deepPurple
                  : GlobalColors.primaryBlack.withAlpha(50))),
      alignment: Alignment.center,
      child: Text(
        pinText,
        style: GlobalTextStyles.purpleBoldText(context: context),
      ),
    );
  }
}
