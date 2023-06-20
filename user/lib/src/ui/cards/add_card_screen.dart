import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared/shared.dart';
import 'package:user/src/ui/cards/add_card_vm.dart';

class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  final nameOnCardController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryMonthController = TextEditingController();
  final expiryYearController = TextEditingController();
  final cvvController = TextEditingController();
  var checkBoxState = false;

  @override
  Widget build(BuildContext context) {
    var cardNumber = '****  ****  ****  ****';
    var cvvNumber = '****';
    var expDate = '****';

    return Scaffold(
      backgroundColor: GlobalColors.globalWhite,
      body: GestureDetector(
        onTap: () => context.closeKeyboard(context),
        child: SingleChildScrollView(
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
                                        style:
                                            GlobalTextStyles.regularTextWhite(
                                                context: context,
                                                fontSize: 14,
                                                alpha: 100)),
                                    Text(expDate,
                                        style:
                                            GlobalTextStyles.regularTextWhite(
                                                context: context,
                                                fontSize: 20)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('CVV',
                                        style:
                                            GlobalTextStyles.regularTextWhite(
                                                context: context,
                                                fontSize: 14,
                                                alpha: 100)),
                                    Text(cvvNumber,
                                        style:
                                            GlobalTextStyles.regularTextWhite(
                                                context: context,
                                                fontSize: 20)),
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
                              fieldName: 'Name on card',
                              maxLength: 16,
                              removeSpace: false,
                              keyBoardType: TextInputType.name,
                              textController: nameOnCardController),
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
                      const SizedBox(height: 30),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          InkWell(
                            radius: 10,
                            onTap: () =>
                                setState(() => checkBoxState = !checkBoxState),
                            child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                                padding: const EdgeInsets.all(2),
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: checkBoxState
                                        ? GlobalColors.primaryBlack
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: GlobalColors.primaryBlack
                                            .withAlpha(80),
                                        width: 2)),
                                child: checkBoxState
                                    ? SvgPicture.asset(
                                        'assets/images/tick_icon.svg',
                                        height: 15)
                                    : const SizedBox.shrink()),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            radius: 10,
                            onTap: () =>
                                setState(() => checkBoxState = !checkBoxState),
                            child: Text(
                              'SET AS DEFAULT',
                              style: GlobalTextStyles.regularText(
                                  context: context),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      GlobalButton(
                          title: 'Add card',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ref.read(addCardVM).addCardDetails(
                                  cardName: nameOnCardController.text,
                                  isDefault: checkBoxState,
                                  context: context,
                                  cardNumber: cardNumberController.text,
                                  expiryMonth: expiryMonthController.text,
                                  expiryYear: expiryYearController.text,
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
      ),
    );
  }
}
