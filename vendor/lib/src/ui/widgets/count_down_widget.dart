
// ignore_for_file: must_be_immutable

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CountDown extends StatelessWidget {
  CountDown({Key? key, this.duration = 65}) : super(key: key);
  final int? duration;
  final CountDownController _controller = CountDownController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 15.h,
        child: CircularCountDownTimer(
          width: 30.w,
          height: 30.h,
          duration: duration!,
          fillColor: const Color(0xff654DE4),
          ringColor: const Color(0xffD1D1D1),
          controller: _controller,
          backgroundColor: Colors.white54,
          strokeWidth: 5.0,
          strokeCap: StrokeCap.round,
          isTimerTextShown: true,
          isReverse: true,
          isReverseAnimation: true,
          onComplete: () {},
          textStyle: TextStyle(fontSize: 13.sp, color: Colors.black),
        ),
      ),
    );
  }
}
