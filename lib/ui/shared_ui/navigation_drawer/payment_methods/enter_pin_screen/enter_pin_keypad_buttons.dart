// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/all.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import 'enter_pin_button_widget.dart';
//
// class EnterPinKeypadButtons extends ConsumerWidget {
//   const EnterPinKeypadButtons({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, watch) {
//     final pinCode = watch(inputText).state;
//
//     return Padding(
//       padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 EnterPinKeypadButtonWidget(buttonText: '1'),
//                 EnterPinKeypadButtonWidget(buttonText: '2'),
//                 EnterPinKeypadButtonWidget(buttonText: '3'),
//               ]),
//           SizedBox(height: 10),
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 EnterPinKeypadButtonWidget(buttonText: '4'),
//                 EnterPinKeypadButtonWidget(buttonText: '5'),
//                 EnterPinKeypadButtonWidget(buttonText: '6'),
//               ]),
//           SizedBox(height: 10),
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 EnterPinKeypadButtonWidget(buttonText: '7'),
//                 EnterPinKeypadButtonWidget(buttonText: '8'),
//                 EnterPinKeypadButtonWidget(buttonText: '9'),
//               ]),
//           SizedBox(height: 10),
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Text('          '),
//             EnterPinKeypadButtonWidget(buttonText: '0'),
//             Container(
//               decoration: const BoxDecoration(
//                   shape: BoxShape.circle
//               ),
//               padding: EdgeInsets.all(10),
//               child: InkWell(
//                 onTap: () {
//                   if (pinCode.isNotEmpty) {
//                     context.read(inputText).state =
//                         pinCode.substring(0, pinCode.length - 1);
//                   }
//                 },
//                 child: Container(
//                     padding: EdgeInsets.all(10),
//                     child: SvgPicture.asset('assets/images/back_icon.svg')),
//               ),
//             ),
//           ]),
//         ],
//       ),
//     );
//   }
// }
