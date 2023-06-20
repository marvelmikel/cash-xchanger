
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalTextField extends StatefulWidget {
  final String fieldName;
  final String hintText;
  final TextInputType keyBoardType;
  final TextEditingController textController;
  final void Function(String)? onChange;
  final int maxLength;
  final bool isCenterText;
  final bool isEyeVisible;
  final bool removeSpace;
  bool? obscureText;

  GlobalTextField(
      {Key? key,
        required this.fieldName,
        required this.keyBoardType,
        required this.textController,
        this.onChange,
        this.hintText = '',
        this.removeSpace = true,
        this.obscureText = false,
        this.isCenterText = false,
        this.isEyeVisible = false,
        this.maxLength = 35})
      : super(key: key);

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
        obscureText: widget.obscureText!,
        onChanged: widget.onChange,
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
          hintText: widget.hintText,
          floatingLabelStyle: TextStyle(color: GlobalColors.purpleBlue),
          isDense: true,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          suffixIcon: Visibility(
            visible: widget.isEyeVisible,
            child: IconButton(
                onPressed: () =>
                    setState(() => widget.obscureText = !widget.obscureText!),
                icon: Icon(
                  widget.obscureText!
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                  color: GlobalColors.purpleBlue,
                )),
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
            borderSide: BorderSide(color: GlobalColors.purpleBlue, width: 0.5),
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
            if (value.length != 14) {
              return 'Phone number must be 14 digits';
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



class EditTextField extends StatefulWidget {
  final TextEditingController textController;
  final bool enabled;
  final double padding;
  final Color fillingColor;
  bool isCurrency;
  final TextInputFormatter? formatter;
  final void Function(String)? onChange;

  EditTextField(
      {Key? key,
        required this.textController,
        this.enabled = true,
        this.padding = 80,
        this.isCurrency = false,
        this.formatter,
        this.fillingColor = const Color(0xff061E38),
        this.onChange})
      : super(key: key);

  @override
  State<EditTextField> createState() => _PlanVestTextFieldState();
}

class _PlanVestTextFieldState extends State<EditTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.padding,
      ),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.textController,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.number,
        inputFormatters: [
          widget.isCurrency
              ? widget.formatter!
              : FilteringTextInputFormatter.deny(RegExp(r'\s')),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        style: widget.fillingColor == Colors.transparent
            ? GlobalTextStyles.regularMediumH(fontSize: 20, alpha: 70)
            : GlobalTextStyles.regularMediumWhiteH(
            context: context, fontSize: 20),
        onChanged: widget.onChange,
        decoration: InputDecoration(
          fillColor: widget.fillingColor,
          hintText: '0.0',
          hintStyle: widget.fillingColor == Colors.transparent
              ? GlobalTextStyles.regularMediumH(fontSize: 20, alpha: 70)
              : GlobalTextStyles.regularMediumWhiteH(
              context: context, fontSize: 20, alpha: 70),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: GlobalColors.deepPurple)),
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
