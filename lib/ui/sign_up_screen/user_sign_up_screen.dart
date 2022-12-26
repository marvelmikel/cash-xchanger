import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/ui/global_widgets/global_button.dart';
import 'package:cash_xchanger/ui/global_widgets/global_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../cubit/auth_cubit/register_cubit.dart';
import '../../database/models/auth/register_model.dart';
import '../overview_screen/user_cash_widget.dart';

final registerEmail = ValueNotifier('');

class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({Key? key}) : super(key: key);

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  final userNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final firstNameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final passwordController = TextEditingController();

  var checkBoxState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: 20, right: 20, top: GlobalSizes.topSpacing(context)),
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: userType,
              builder: (context, value, child) {
                return Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign up',
                        style: GlobalTextStyles.blueBoldText(
                            context: context, fontSize: 32),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'as cash $value',
                        style: GlobalTextStyles.blueBoldText(
                            context: context, fontSize: 25),
                      ),
                      SizedBox(height: GlobalSizes.globalWidth(context, 0.1)),
                      Center(
                          child: SvgPicture.asset(
                              'assets/images/timeline_two.svg')),
                      SizedBox(height: GlobalSizes.globalWidth(context, 0.17)),
                      Text(
                        'Please enter your details to continue.',
                        style: GlobalTextStyles.regularText(context: context),
                      ),
                      GlobalTextField(
                          fieldName: 'First name',
                          keyBoardType: TextInputType.name,
                          textController: firstNameController),
                      GlobalTextField(
                          fieldName: 'Last name',
                          keyBoardType: TextInputType.name,
                          textController: lastNameController),
                      GlobalTextField(
                          fieldName: 'Profile name',
                          keyBoardType: TextInputType.text,
                          textController: userNameController),
                      GlobalTextField(
                          fieldName: 'Email address',
                          keyBoardType: TextInputType.emailAddress,
                          textController: emailController),
                      GlobalTextField(
                          fieldName: 'Phone number',
                          maxLength: 14,
                          keyBoardType: TextInputType.phone,
                          textController: phoneNumberController),
                      GlobalTextField(
                          fieldName: 'Password',
                          obscureText: true,
                          isEyeVisible: true,
                          keyBoardType: TextInputType.name,
                          textController: passwordController),
                      SizedBox(height: GlobalSizes.globalHeight(context, 0.05)),
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
                                    color: checkBoxState == true
                                        ? GlobalColors.primaryBlack
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: GlobalColors.primaryBlack
                                            .withAlpha(80),
                                        width: 2)),
                                child: checkBoxState == true
                                    ? SvgPicture.asset(
                                        'assets/images/tick_icon.svg',
                                        height: 15)
                                    : const SizedBox.shrink()),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () =>
                                context.read<RegisterCubit>().readPrivacy(),
                            child: RichText(
                              text: TextSpan(
                                text: 'I agree with ',
                                style: GlobalTextStyles.regularText(
                                    context: context),
                                children: [
                                  TextSpan(
                                      text: 'terms',
                                      style: GlobalTextStyles.blueBoldText(
                                          context: context, fontSize: 16)),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                      text: 'policies',
                                      style: GlobalTextStyles.blueBoldText(
                                          context: context, fontSize: 16)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      GlobalButton(
                        buttonText: 'Create account',
                        isButtonColorGreen: true,
                        isDisabled: !checkBoxState,
                        onTap: () {
                          if (formKey.validate) {
                            if (checkBoxState) {
                              registerEmail.value = emailController.text;
                              context.read<RegisterCubit>().register(
                                  payload: RegisterModel(
                                    username: userNameController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    isVendor: value.toString() != 'user',
                                    phoneNumber: phoneNumberController.text,
                                    password: passwordController.text,
                                  ),
                                  context: context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Please agree with the terms.');
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(100),
                        child: Center(
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Already have an account? ',
                                  style: GlobalTextStyles.regularText(
                                      context: context),
                                  children: [
                                    TextSpan(
                                        text: 'Login',
                                        style:
                                            GlobalTextStyles.regularGreenText(
                                                context: context)),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(height: 50)
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
