import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalTextField extends StatefulWidget {
  final String fieldName;
  final TextInputType keyBoardType;
  final TextEditingController textController;
  final int maxLength;
  final bool isCenterText;
  final bool isEyeVisible;
  final bool removeSpace;
  late   bool obscureText;

    GlobalTextField(
      {Key? key, required this.fieldName,
      required this.keyBoardType,
      required this.textController,
      this.removeSpace = true,
      this.obscureText = false,
      this.isCenterText = false,
      this.isEyeVisible = false,
      this.maxLength = 35}) : super(key: key);

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: widget.textController,
        keyboardType: widget.keyBoardType,
        obscureText: widget.obscureText,
        textAlign: widget.isCenterText ? TextAlign.center : TextAlign.start,
        textCapitalization: widget.keyBoardType == TextInputType.name
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        inputFormatters: [
          widget.removeSpace
              ? FilteringTextInputFormatter.deny(RegExp(r'\s\b|\b\s'))
              : LengthLimitingTextInputFormatter(widget.maxLength),
          widget.keyBoardType == TextInputType.phone
              ? FilteringTextInputFormatter.deny(RegExp(r'^0+'))
              : LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: widget.fieldName,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          suffixIcon: Visibility(
            visible: widget.isEyeVisible,
            child: IconButton(
                onPressed: () =>
                    setState(() => widget.obscureText = !widget.obscureText),
                icon: const Icon(Icons.remove_red_eye)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: GlobalColors.ashWhite, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 0.5)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: GlobalColors.primaryGreen, width: 0.5),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'This input is empty';
          } else if (widget.keyBoardType == TextInputType.emailAddress) {
            bool isValid = isValidEmail(context, value);
            if (!isValid) {
              return 'Not a valid email';
            }
          } else if (widget.keyBoardType == TextInputType.phone) {
            if (value.length != 10) {
              return 'Phone number must be 10 digits';
            }
          } else if (widget.keyBoardType == TextInputType.name) {
            if (value.length < 3) {
              return 'Not a valid name';
            }
          } else {
            return null;
          }
          return null;
        },
      ),
    );
  }
}
