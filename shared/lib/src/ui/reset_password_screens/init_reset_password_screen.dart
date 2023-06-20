
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


import '../../ui.dart';
import 'models/reset_model.dart';

final resetModelListener = ValueNotifier(ResetModel());

class InitResetScreen extends StatefulWidget {
  const InitResetScreen({Key? key}) : super(key: key);

  @override
  State<InitResetScreen> createState() => _InitResetScreenState();
}

class _InitResetScreenState extends State<InitResetScreen> {
  GlobalKey<FormState> globalKey = GlobalKey();

  final emailController = TextEditingController();

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
                SizedBox(height: 5.h),
                Text(
                  'Please enter your registered email address',
                  style: GlobalTextStyles.regularText(context: context),
                ),
                SizedBox(height: 5.h),
                GlobalTextField(
                    fieldName: 'Email address',
                    keyBoardType: TextInputType.emailAddress,
                    textController: emailController),
                SizedBox(height: 10.h),
                GlobalButton(
                    title: 'Reset password',

                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        resetModelListener.value.email = emailController.text;
                        // getItInstance<ResetCubit>().initReset(
                        //     context: context, username: emailController.text);
                      }
                    }),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.04)),
                GlobalButton(
                  title: 'Go back',
                  foreground: GlobalColors.primaryBlue,
                  background: Colors.transparent,
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.04)),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(100),
                  child: Center(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: RichText(
                          text: TextSpan(
                            text: 'Don’t have an account? ',
                            style:
                                GlobalTextStyles.regularText(context: context),
                            children: [
                              TextSpan(
                                  text: 'Signup',
                                  style: GlobalTextStyles.regularGreenText(
                                      context: context, fontSize: 16)),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
