import 'dart:io';

import 'package:core/core.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DropdownInput<T> extends StatelessWidget {
  final FocusNode? focusNode;
  final T? value;
  final Function(Object?)? onChanged;
  final Function(T)? done;
  final Function()? onTap;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool showToplabel;
  final List<InputItem<T>>? options;
  final BoxDecoration? decoration;
  final TextStyle? style;
  final TextStyle? textStyle;
  final Color? foreground;
  final bool isDense;
  final bool hasBorder;
  final Widget? prefix;
  final bool isLoading;
  final Widget? suffix;
  final Size? iconSize;
  final String? Function(T?)? validator;
  final EdgeInsets? horizontalPadding;
  const DropdownInput(
      {Key? key,
        this.focusNode,
        this.value,
        this.onChanged,
        this.label,
        this.options,
        this.decoration,
        this.showToplabel = false,
        this.style,
        this.textStyle,
        this.isDense = false,
        this.hasBorder = true,
        this.iconSize,
        this.horizontalPadding,
        this.prefix,
        this.errorText,
        this.foreground,
        this.suffix,
        this.hint,
        this.done,
        this.isLoading = false,
        this.onTap,
        this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: !(options != null && options!.isNotEmpty && !isLoading)
              ? onTap
              : () {
            WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
            if (Platform.isAndroid) return;

            _select(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AbsorbPointer(
                absorbing: Platform.isIOS,
                child: DropdownButton2<Object>(
                  isExpanded: true,
                  autofocus: false,
                  focusColor: GlobalColors.blueColor.withOpacity(0),
                  hint: Row(
                    children: [
                      Flexible(
                        child: Text(hint ?? label!,
                            style: style ??
                                TextStyle(
                                  color: GlobalColors.primaryBlack,
                                  fontSize: 18.sp,
                                  //letterSpacing: 1.3,k
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                )),
                      ),
                    ],
                  ),
                  items: [
                    for (var option in options!)
                      DropdownMenuItem(
                        value: option.value,
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(option.title,
                                  style: GlobalTextStyles.regularText(
                                      context: context, fontSize: 16)),
                            ),
                          ],
                        ),
                      )
                  ],
                  focusNode: focusNode,
                  value: value,
                  onChanged: onChanged,
                  underline: hasBorder
                      ? Divider(
                    color: const Color(0xff1d4038).withOpacity(0.15),
                    height: 0.8,
                    thickness: 1.2,
                  )
                      : const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconEnabledColor: GlobalColors.primaryBlue.withOpacity(0.5),
                  iconDisabledColor: GlobalColors.primaryBlue.withOpacity(0.2),
                  buttonPadding: hasBorder
                      ? const EdgeInsets.only(
                      top: 15, bottom: 15, left: 0, right: 0)
                      : const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 5),
                  buttonElevation: 2,
                  itemHeight: 37,
                  // itemWidth: 210,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: GlobalColors.washedWhite,
                      boxShadow: [
                        BoxShadow(
                            color: GlobalColors.primaryBlue.withOpacity(0.1),
                            blurRadius: 10.0,
                            offset: const Offset(3.0, 3.0))
                      ]),
                  scrollbarAlwaysShow: false,
                  offset: const Offset(0, -5),
                ),
              ),
              if (errorText != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 10),
                    child: Text(errorText ?? '',
                        style:
                        Theme.of(context).inputDecorationTheme.errorStyle),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  Future _select(
      BuildContext context,
      ) async {
    T val = value ?? options![0].value;
    var background = GlobalColors.washedWhite;

    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: background,
      builder: (c) => SizedBox(
        height: 300,
        child: Theme(
          data: Theme.of(context).copyWith(
            cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  textStyle: TextStyle(
                    color: GlobalColors.primaryBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  actionTextStyle: TextStyle(
                    color: GlobalColors.primaryBlack.withOpacity(0.5),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                )),
            // brightness: Brightness.dark
          ),
          child: Column(
            children: [
              Container(
                color: background,
                alignment: Alignment.centerRight,
                child: TextButton(
                  // textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(c).pop();
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: GlobalColors.primaryBlack.withOpacity(0.5),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    )),
              ),
              Divider(height: 2, thickness: 1, color: GlobalColors.primaryBlue),
              Expanded(
                child: CupertinoPicker.builder(
                    scrollController: FixedExtentScrollController(
                        initialItem:
                        options!.indexWhere((v) => v.value == value)),
                    onSelectedItemChanged: (i) {
                      onChanged!(options![i].value);
                      val = options![i].value;
                    },
                    itemExtent: 25,
                    diameterRatio: 2,
                    magnification: 1.3,
                    backgroundColor: background,
                    useMagnifier: true,
                    squeeze: .7,
                    childCount: options?.length ?? 0,
                    itemBuilder: (c, i) => Center(
                      child: Text(options![i].title,
                          style: style?.copyWith(
                            // color: Color(0xff283461),

                              color: Colors.black,
                              //     // decorationColor: Colors.white,
                              backgroundColor: Colors.white,
                              fontWeight: FontWeight.w400)),
                    )),
              ),
            ],
          ),
        ),
      ),
    ).then((value) {
      if (done != null) done!(val);
    });
  }
}

class InputItem<T> {
  final T value;
  final String title;

  InputItem(this.value, this.title);
}

class DropDownLists {
  final List<InputItem> values;

  DropDownLists(this.values);
}
