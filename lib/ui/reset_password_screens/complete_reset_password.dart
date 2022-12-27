import 'package:cash_xchanger/cubit/auth_cubit/reset_cubit.dart';
import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../database/models/auth/reset_model.dart';
import 'init_reset_password_screen.dart';

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
                    style: GlobalTextStyles.blueBoldText(
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
                          buttonText: 'Confirm password',
                          isButtonColorGreen: true,
                          onTap: () {
                            payload.password = passwordController2.text;
                            if (globalKey.validate) {
                              if (passwordController.text ==
                                  passwordController2.text) {
                                getItInstance<ResetCubit>().resetPassword(
                                    context: context, payload: payload);
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Password Mismatch');
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
