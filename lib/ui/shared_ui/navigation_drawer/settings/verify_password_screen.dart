import 'package:cash_xchanger/cubit/nav_bar_cubit/nav_drawer_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_gray_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global_widgets/global_text_field.dart';

class VerifyPasswordScreen extends StatelessWidget {
  VerifyPasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColors.globalWhite,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Verify your password',
                style: GlobalTextStyles.blueBoldText(context: context)),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: formKey,
                child: GlobalTextField(
                    fieldName: 'Password',
                    obscureText: true,
                    isEyeVisible: true,
                    keyBoardType: TextInputType.name,
                    textController: passwordController),
              ),
            ),
            const SizedBox(height: 40),
            GlobalButton(
              buttonText: 'Continue',
              horizontalMargin: 30,
              onTap: () {
                if (formKey.validate) {
                  context.read<NavDrawerCubit>().verifyPassword(
                      context: context, password: passwordController.text);
                }
              },
            ),
            const SizedBox(height: 20),
            GlobalGrayButton(
              buttonText: 'Cancel',
              horizontalMargin: 30,
              onTap: () => Navigator.pop(context),
            )
          ],
        )));
  }
}
