
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final filterText = ValueNotifier('');


class SearchTextField extends StatefulWidget {
  final String fieldName;
  final TextEditingController textController;
  final int maxLength;

  const SearchTextField(
      {Key? key,
        required this.fieldName,
        required this.textController,
        this.maxLength = 35})
      : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: widget.textController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        onChanged: (value) {
          filterText.value = value;
        },
        inputFormatters: [LengthLimitingTextInputFormatter(widget.maxLength)],
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: widget.fieldName,
          isDense: true,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: GlobalColors.ashWhite, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: GlobalColors.primaryGreen),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'This input is empty';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
