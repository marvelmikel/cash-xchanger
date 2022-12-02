// import 'package:cash_xchanger/helpers/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/all.dart';
// import 'package:rive/rive.dart';
//
// final pinKeypadEquation = StateProvider.autoDispose((ref) => '');
// final inputText = StateProvider.autoDispose((ref) => '');
//
// class EnterPinKeypadButtonWidget extends ConsumerWidget {
//   const EnterPinKeypadButtonWidget({Key? key, required this.buttonText})
//       : super(key: key);
//
//   final String buttonText;
//
//   @override
//   Widget build(BuildContext context, watch) {
//     final pinCode = watch(inputText).state;
//
//     return InkWell(
//       onTap: () {
//         if(pinCode.length < 4){
//           context.read(inputText).state = pinCode + buttonText;
//         }
//       },
//       child: Container(
//         decoration: const BoxDecoration(
//           shape: BoxShape.circle
//         ),
//         padding: EdgeInsets.all(25),
//         child: Text(
//           buttonText,
//           style: GlobalTextStyles.blueMediumText(context: context, fontSize: 30),
//         ),
//       ),
//     );
//   }
// }
