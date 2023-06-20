
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';




class VerifyPasswordScreen extends ConsumerWidget {
  VerifyPasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        backgroundColor: GlobalColors.globalWhite,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Verify your password',
                style: GlobalTextStyles.boldText(context: context)),
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
              title: 'Continue',

              onPressed: () {
                 if (formKey.currentState!.validate()) {
                //   // context.read<NavDrawerCubit>().verifyPassword(
                //   //     context: context, password: passwordController.text);
                 }
              },
            ),
            const SizedBox(height: 20),
            GlobalButton(
              title: 'Cancel',
              background: Colors.transparent,
              onPressed: () => Navigator.pop(context),
            )
          ],
        )));
  }
}
