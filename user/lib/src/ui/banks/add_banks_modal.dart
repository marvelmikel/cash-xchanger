import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';
import 'package:user/src/ui/banks/search_bank_modal.dart';

class AddBankBottomSheet extends ConsumerStatefulWidget {
  const AddBankBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddBankBottomSheet> createState() => _AddBankBottomSheetState();
}

class _AddBankBottomSheetState extends ConsumerState<AddBankBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileViewModelProviderV1);
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
                    profile.getNigerianBanks();
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => SearchBankBottomSheet(
                            accountNumber: accountNumberController.text));
                  } else {
                    alert(description: 'Account number must be 10 digits');
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: GlobalColors.ashWhite, width: 1.5)),
                  child: Text(
                    profile.bankInfoModel.bankName,
                    style: GlobalTextStyles.regularText(
                        context: context, fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  profile.bankInfoModel.accountName,
                  style: GlobalTextStyles.regularText(
                      context: context, fontSize: 16, alpha: 80),
                ),
              ),
              const SizedBox(height: 90),
              GlobalButton(
                  title: 'Continue',
                  onPressed: () {
                    if (profile.bankInfoModel.bankName.isNotEmpty) {
                      profile.addBank();
                    } else {
                      alert(description: 'Bank info must be supplied');
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
