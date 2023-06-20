
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
const kToastDuration = Duration(seconds: 4);

ToastFuture alert({ String type = 'error', required String description}) =>
    showToastWidget(ToastWidget(type: type, description: description),
        duration: kToastDuration, handleTouch: true);




class ToastWidget extends StatelessWidget {
  final String type;
  final String description;
  const ToastWidget({Key? key, required this.type, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: type == 'error'
                      ? const Color(0xfffd646f)
                      : const Color(0xff083F08)),
              color: type == 'error'
                  ? const Color(0xfffd646f)
                  : const Color(0xff083F08)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Hellix',
                      fontSize: 10.sp,
                      color: Colors.white,
                    ),
                  )),
              // SubText(
              //   text: "Okay",
              //   foreground: lightColor,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
