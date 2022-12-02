// import 'package:cash_xchanger/helpers/colors.dart';
// import 'package:cash_xchanger/helpers/text_styles.dart';
// import 'package:cash_xchanger/ui/global_widgets/back_button.dart';
// import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
// import 'package:cash_xchanger/ui/navigation_drawer/payment_methods/add_card_screen/add_card_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// import '../../../../database/boxes.dart';
// import '../../../../database/cards_model/card_list_model.dart';
// import '../enter_pin_screen/enter_pin_screen.dart';
//
// class SelectCardScreen extends StatelessWidget {
//   const SelectCardScreen({Key? key, required this.amount}) : super(key: key);
//
//   final String amount;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: GlobalColors.primaryBlue,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const BackButtonWidget(backButtonText: 'Select a card'),
//           const SizedBox(height: 30),
//           Padding(
//             padding: EdgeInsets.only(left: 20, right: 100),
//             child: Text(
//               'Select the card you want to '
//               'fund from.',
//               style: GlobalTextStyles.regularGreenText(
//                   context: context, fontSize: 14),
//             ),
//           ),
//           const SizedBox(height: 40),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               height: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: 30),
//               decoration: BoxDecoration(
//                   color: GlobalColors.globalWhite,
//                   borderRadius:
//                       BorderRadius.vertical(top: Radius.circular(20))),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 60),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(width: 40),
//                       GestureDetector(
//                         onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AddCardBottonScreen())),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 20, bottom: 20),
//                           child: Row(
//                             children: [
//                               Text('Add card',
//                                   style: GlobalTextStyles.regularText(
//                                       context: context, fontSize: 16)),
//                               SizedBox(width: 20),
//                               SvgPicture.asset(
//                                   'assets/images/circle_plus_icon.svg')
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Flexible(
//                     child: MediaQuery.removePadding(
//                       context: context,
//                       removeLeft: true,
//                       child: ValueListenableBuilder<Box<CardListModel>>(
//                           valueListenable: GlobalBoxes.getCards().listenable(),
//                           builder: (context, box, _) {
//                             final cardList = box.values.toList();
//                             return cardList.isEmpty
//                                 ? Expanded(
//                                     child: Column(
//                                       children: [
//                                         SizedBox(height: 10),
//                                         SvgPicture.asset(
//                                             'assets/images/no_card.svg',
//                                             height: 70),
//                                         SizedBox(height: 10),
//                                         Text('No cards added')
//                                       ],
//                                     ),
//                                   )
//                                 : ListView.builder(
//                                     itemCount: cardList.length,
//                                     itemBuilder: (context, index) =>
//                                         CardWidgetItem(
//                                           amount: amount,
//                                           cardListModel: cardList[index],
//                                         ));
//                           }),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class CardWidgetItem extends StatelessWidget {
//   const CardWidgetItem({Key? key,
//     required this.cardListModel,
//     required this.amount
//   })
//       : super(key: key);
//
//   final CardListModel cardListModel;
//   final String amount;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     EnterPinScreen(amount: amount))),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//         margin: EdgeInsets.only(bottom: 10),
//         decoration: BoxDecoration(
//             color: GlobalColors.globalWhite,
//             border: Border.all(color: GlobalColors.ashWhite),
//             borderRadius: BorderRadius.circular(10)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: GlobalColors.ashWhite),
//                 ),
//                 child:
//                     SvgPicture.asset('assets/images/master_card_icon.svg')),
//             SizedBox(width: 100),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(cardListModel.expiryDate),
//                   Text('**** ${cardListModel.cardNumber.substring(0, 4)}'
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
