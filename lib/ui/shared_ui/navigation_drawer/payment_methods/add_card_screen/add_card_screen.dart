import 'package:cash_xchanger/cubit/payment_cubit/payment_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_text_field.dart';
import 'package:cash_xchanger/ui/global_widgets/profile_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  final cardNumberController = TextEditingController();
  final expiryMonthController = TextEditingController();
  final expiryYearController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cardNumber = '****  ****  ****  ****';
    var cvvNumber = '****';
    var expDate = '****';

    return Scaffold(
      backgroundColor: GlobalColors.globalWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileBackButtonWidget(
                text: 'Add new card', isImageVisible: false),
            SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: GlobalColors.primaryBlack,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/images/chip_icon.svg',
                                fit: BoxFit.cover,
                              ),
                              SvgPicture.asset(
                                'assets/images/bank logo.svg',
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          Text(
                            cardNumber,
                            style: TextStyle(
                                fontFamily: 'nunito',
                                letterSpacing: 4,
                                color: GlobalColors.globalWhite,
                                fontWeight: FontWeight.w700,
                                fontSize: 22),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Expiry Date',
                                      style: GlobalTextStyles.regularTextWhite(
                                          context: context,
                                          fontSize: 14,
                                          alpha: 100)),
                                  Text(expDate,
                                      style: GlobalTextStyles.regularTextWhite(
                                          context: context, fontSize: 20)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CVV',
                                      style: GlobalTextStyles.regularTextWhite(
                                          context: context,
                                          fontSize: 14,
                                          alpha: 100)),
                                  Text(cvvNumber,
                                      style: GlobalTextStyles.regularTextWhite(
                                          context: context, fontSize: 20)),
                                ],
                              ),
                              SvgPicture.asset(
                                  'assets/images/master_card_icon.svg')
                            ],
                          )
                        ],
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(children: [
                        GlobalTextField(
                            fieldName: 'Card number',
                            maxLength: 16,
                            keyBoardType: TextInputType.number,
                            textController: cardNumberController),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: GlobalTextField(
                                  fieldName: 'Exp month',
                                  maxLength: 2,
                                  keyBoardType: TextInputType.number,
                                  textController: expiryMonthController),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: GlobalTextField(
                                  fieldName: 'Exp year',
                                  maxLength: 2,
                                  keyBoardType: TextInputType.number,
                                  textController: expiryYearController),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GlobalTextField(
                                  fieldName: 'CVV',
                                  maxLength: 3,
                                  keyBoardType: TextInputType.number,
                                  textController: cvvController),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                                child: Text(
                              '3 or 4 digits usually found on the signature strip',
                              style: GlobalTextStyles.regularText(
                                  context: context, alpha: 100, fontSize: 14),
                            ))
                          ],
                        ),
                      ]),
                    ),
                    const SizedBox(height: 60),
                    GlobalButton(
                        buttonText: 'Add card',
                        isButtonColorGreen: true,
                        onTap: () {
                          if (formKey.validate) {
                            context.read<PaymentCubit>().addCardDetails(
                                context: context,
                                cardNumber: cardNumberController.text,
                                expDate: '${expiryMonthController.text}/${expiryYearController.text}',
                                cvv: cvvController.text);
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
