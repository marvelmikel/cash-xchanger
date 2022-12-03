import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditTextField extends StatefulWidget {
  final TextEditingController textController;
  final bool enabled;

  const EditTextField(
      {Key? key, required this.textController, this.enabled = true})
      : super(key: key);

  @override
  State<EditTextField> createState() => _PlanVestTextFieldState();
}

class _PlanVestTextFieldState extends State<EditTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.textController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        style: GlobalTextStyles.blueMediumText(context: context, fontSize: 40),
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: '0.0',
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  const BorderSide(color: GlobalColors.materialPrimaryColor)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.red)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: GlobalColors.primaryGreen),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'This must not be empty';
          }
          return null;
        },
      ),
    );
  }
}
