import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/nav_bar_cubit/nav_drawer_cubit.dart';

class ChangePinBottomSheet extends StatefulWidget {
  const ChangePinBottomSheet({Key? key}) : super(key: key);

  @override
  State<ChangePinBottomSheet> createState() => _ChangePinBottomSheetState();
}

class _ChangePinBottomSheetState extends State<ChangePinBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                'Change Transaction Pin',
                style: GlobalTextStyles.greenMediumText(
                    context: context, fontSize: 16),
              ),
              Form(
                key: formKey,
                child: GlobalTextField(
                    fieldName: 'Transaction Pin',
                    isCenterText: true,
                    keyBoardType: TextInputType.number,
                    maxLength: 4,
                    textController: pinController),
              ),
              const SizedBox(height: 90),
              GlobalButton(
                  buttonText: 'Continue',
                  onTap: () {
                    if (formKey.validate) {
                      context
                          .read<NavDrawerCubit>()
                          .addPin(context: context, pin: pinController.text);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
