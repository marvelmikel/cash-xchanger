// import 'package:cash_xchanger/helpers/colors.dart';
// import 'package:cash_xchanger/helpers/text_styles.dart';
// import 'package:cash_xchanger/ui/global_widgets/back_button.dart';
// import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
// import 'package:cash_xchanger/ui/helper_screens/success_top_up.dart';
// import 'package:cash_xchanger/ui/navigation_drawer/payment_methods/enter_pin_screen/pin_text_field_widget.dart';
// import 'package:cash_xchanger/ui/navigation_drawer/payment_methods/enter_pin_screen/enter_pin_keypad_buttons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import 'enter_pin_button_widget.dart';
//
// class EnterPinScreen extends ConsumerWidget {
//   EnterPinScreen({Key? key, required this.amount}) : super(key: key);
//
//   final String amount;
//
//   @override
//   Widget build(BuildContext context, watch) {
//     final pinCode = watch(inputText).state;
//
//     return Scaffold(
//       backgroundColor: GlobalColors.primaryBlue,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const BackButtonWidget(backButtonText: 'Enter pin'),
//           const SizedBox(height: 30),
//           Padding(
//             padding: EdgeInsets.only(left: 20, right: 100),
//             child: Text(
//               'Input your transaction pin',
//               style: GlobalTextStyles.regularGreenText(
//                   context: context, fontSize: 14),
//             ),
//           ),
//           const SizedBox(height: 40),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               height: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: 40),
//               decoration: BoxDecoration(
//                   color: GlobalColors.globalWhite,
//                   borderRadius:
//                       BorderRadius.vertical(top: Radius.circular(20))),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   PinTextField(),
//                   EnterPinKeypadButtons(),
//                   GlobalButton(
//                       buttonText: 'Proceed',
//                       isButtonColorGreen: true,
//                       onTap: () {
//                         if (pinCode.length == 4) {
//                           print(pinCode);
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => SuccessTopUp()));
//                         }
//                       }),
//                   SizedBox(height: 30)
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
