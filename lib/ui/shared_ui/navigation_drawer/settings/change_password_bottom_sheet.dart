import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_text_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  const ChangePasswordBottomSheet({Key? key}) : super(key: key);

  @override
  State<ChangePasswordBottomSheet> createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                'Change Password',
                style: GlobalTextStyles.greenMediumText(
                    context: context, fontSize: 16),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    GlobalTextField(
                        fieldName: 'Old Password',
                        keyBoardType: TextInputType.visiblePassword,
                        maxLength: 20,
                        textController: oldPasswordController),
                    GlobalTextField(
                        fieldName: 'New Password',
                        keyBoardType: TextInputType.visiblePassword,
                        maxLength: 20,
                        textController: newPasswordController),
                    GlobalTextField(
                        fieldName: 'Confirm Password',
                        keyBoardType: TextInputType.visiblePassword,
                        maxLength: 20,
                        textController: confirmPasswordController),
                  ],
                ),
              ),
              const SizedBox(height: 90),
              GlobalButton(
                  buttonText: 'Continue',
                  onTap: () {
                    if (formKey.validate) {
                      getItInstance<ProfileCubit>().changePassword(
                          previousPassword: oldPasswordController.text,
                          newPassword: newPasswordController.text,
                          context: context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
