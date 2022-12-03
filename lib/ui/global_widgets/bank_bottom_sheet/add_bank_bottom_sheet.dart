import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../cubit/payment_cubit/payment_cubit.dart';
import 'search_bank_bottom_sheet.dart';

class AddBankBottomSheet extends StatefulWidget {
  const AddBankBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AddBankBottomSheet> createState() => _AddBankBottomSheetState();
}

class _AddBankBottomSheetState extends State<AddBankBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(builder: (context, state) {
      return Container(
        height: 550,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Add New Bank',
                  style: GlobalTextStyles.greenMediumText(
                      context: context, fontSize: 16),
                ),
                Form(
                  key: formKey,
                  child: GlobalTextField(
                      fieldName: 'Account number',
                      keyBoardType: TextInputType.number,
                      maxLength: 10,
                      textController: accountNumberController),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (accountNumberController.text.length == 10) {
                      context.read<PaymentCubit>().getNigerianBanks();
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => SearchBankBottomSheet(
                              accountNumber: accountNumberController.text));
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Account number must be 10 digits');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: GlobalColors.ashWhite, width: 1.5)),
                    child: Text(
                      state.bankInfoModel.bankName,
                      style: GlobalTextStyles.regularText(
                          context: context, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Text(
                    state.bankInfoModel.accountName,
                    style: GlobalTextStyles.regularText(
                        context: context, fontSize: 16, alpha: 80),
                  ),
                ),
                const SizedBox(height: 90),
                GlobalButton(
                    buttonText: 'Continue',
                    onTap: () {
                      if (state.bankInfoModel.bankName.isNotEmpty) {
                        context.read<PaymentCubit>().addBank(context: context);
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Bank info must be supplied');
                      }
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
