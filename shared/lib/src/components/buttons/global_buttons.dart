import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GlobalButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String title;
  final bool isBlankBackground;
  final Color borderColor;
  final Color? background;
  final Color? foreground;
  final double? textSize;
  final double? disableOpacity;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool busy;
  final bool isDisabled;
  final bool hasNairaSign;
  final Widget? titlePrefixWidget;
  final Widget? titleSuffixWidget;
  const GlobalButton({
    Key? key,
    this.onPressed,
    this.width,
    this.height = 7,
    required this.title,
    this.hasNairaSign = false,
    this.padding,
    this.busy = false,
    this.borderColor = const Color(0xff083F08),
    this.background = const Color(0xff083F08),
    this.foreground = Colors.white,
    this.textSize = 14,
    this.disableOpacity = 0.2,
    this.borderRadius = 12,
    this.isBlankBackground = true,
    this.isDisabled = false,
    this.titlePrefixWidget,
    this.titleSuffixWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: busy
          ? null
          : isDisabled
              ? null
              : onPressed,
      child: Container(
        padding: padding,
        width: width,
        height: height!.h,
        decoration: BoxDecoration(
          color: isDisabled ? background!.withOpacity(disableOpacity!) : background,
          border: Border.all(
              color:
              isDisabled
                      ? Colors.transparent
                      :   borderColor,
              width: 1.2),
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titlePrefixWidget ?? const SizedBox.shrink(),
            Text(title,
                style: TextStyle(
                  color: foreground,
                  fontSize: textSize!.sp,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                )),
            titleSuffixWidget ?? const SizedBox.shrink(),
          ],
        )),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  SmallButton(
      {Key? key,
        required this.color,
        required this.text,
        this.onTap,
        this.textColor = Colors.black})
      : super(key: key);
  final Function()? onTap;
  final Color color;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5.h,
        width: 30.w,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color, width: 1.2)),
        child: Center(
          child: Text(text,
              style: GlobalTextStyles.regularMediumH(
                fontSize: 14,
              ).copyWith(color: textColor)),
        ),
      ),
    );
  }
}
