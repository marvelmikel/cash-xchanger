import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer(
      {Key? key,
        required this.child,
        this.borderColor = Colors.blueAccent,
        this.borderShadowColor = const Color(0x29000000),
        this.color = const Color(0xffffffff),
        this.height = 30,
        this.width = double.infinity,
        this.circleRadius = 10,
        this.verticalPadding = 0,
        this.horizontalPadding = 0,
        this.borderWidth = 0.5})
      : super(key: key);
  final Color? borderColor;
  final Color? borderShadowColor;
  final Color? color;
  final double? height;
  final double? verticalPadding;
  final double? width;
  final double? horizontalPadding;
  final double? circleRadius;
  final double? borderWidth;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding!, vertical: verticalPadding!),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: child,
      width: width!.w,
      height: height!.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(circleRadius!)),
          border: Border.all(
            color: borderColor!,
            width: borderWidth!,
          ),
          boxShadow: [
            BoxShadow(
                color: borderShadowColor!,
                offset: const Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 0)
          ],
          color: color),
    );
  }
}
