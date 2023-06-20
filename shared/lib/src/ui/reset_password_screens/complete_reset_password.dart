
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../ui.dart';
import 'init_reset_password_screen.dart';
import 'models/reset_model.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  GlobalKey<FormState> globalKey = GlobalKey();

  final passwordController2 = TextEditingController();

  final passwordController = TextEditingController();

  var checkBoxState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: globalKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 20, right: 20, top: GlobalSizes.topSpacing(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reset password',
                    style: GlobalTextStyles.boldText(
                        context: context, fontSize: 32)),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.17)),
                Text(
                  'Enter your new password',
                  style: GlobalTextStyles.regularText(context: context),
                ),
                GlobalTextField(
                    fieldName: 'New Password',
                    obscureText: true,
                    isEyeVisible: true,
                    keyBoardType: TextInputType.name,
                    textController: passwordController2),
                GlobalTextField(
                    fieldName: 'Password',
                    obscureText: true,
                    isEyeVisible: true,
                    keyBoardType: TextInputType.name,
                    textController: passwordController),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.09)),
                ValueListenableBuilder(
                    valueListenable: resetModelListener,
                    builder: (context, ResetModel payload, child) {
                      return GlobalButton(
                          title: 'Confirm password',

                          onPressed: () {
                            payload.password = passwordController2.text;
                            if (globalKey.currentState!.validate()) {
                              if (passwordController.text ==
                                  passwordController2.text) {
                                // getItInstance<ResetCubit>().resetPassword(
                                //     context: context, payload: payload);
                              } else {
                                alert(  description:  'Password Mismatch');
                              }
                            }
                          });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
