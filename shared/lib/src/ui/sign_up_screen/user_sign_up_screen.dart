import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared/src/ui/sign_up_screen/viewmodel/signup_vm.dart';
import '../../ui.dart';
import '../overview_screen/user_cash_widget.dart';
import 'models/register_model.dart';
import 'password_strenght_widget.dart';

final registerEmail = ValueNotifier<RegisterPayload>(RegisterPayload());

class UserSignUpScreen extends ConsumerStatefulWidget {
  UserSignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends ConsumerState<UserSignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final passwordController = TextEditingController();

  var checkBoxState = false;
  bool containUppercase = false;
  bool containLowercase = false;
  bool containDigit = false;
  bool has8Characters = false;
  bool hasSpecialCharacter = false;
  bool showValidation = false;

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
                        style: GlobalTextStyles.boldText(
                            context: context, fontSize: 32),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'as a Cash X $value',
                        style: GlobalTextStyles.boldText(
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
                      value.toString() == 'user'
                          ? GlobalTextField(
                              fieldName: 'Profile name',
                              removeSpace: false,
                              keyBoardType: TextInputType.text,
                              textController: userNameController)
                          : const SizedBox.shrink(),
                      if (value.toString() != 'user') ...[
                        GlobalTextField(
                            fieldName: 'First Name',
                            keyBoardType: TextInputType.name,
                            textController: firstNameController),
                        GlobalTextField(
                            fieldName: 'Last Name',
                            keyBoardType: TextInputType.name,
                            textController: lastNameController),
                      ],
                      GlobalTextField(
                          fieldName: 'Email address',
                          keyBoardType: TextInputType.emailAddress,
                          textController: emailController),
                      GlobalTextField(
                          fieldName: 'Phone number',
                          maxLength: 11,
                          hintText: 'ex 08103456789',
                          keyBoardType: TextInputType.number,
                          textController: phoneNumberController),
                      GlobalTextField(
                          fieldName: 'Password',
                          obscureText: true,
                          isEyeVisible: true,
                          keyBoardType: TextInputType.text,
                          onChange: (password) {
                            if (password == '') {
                              setState(() {
                                showValidation = false;
                              });
                            } else {
                              setState(() {
                                showValidation = true;
                                checkPasswordStrength(password);
                              });
                            }
                          },
                          textController: passwordController),
                      showValidation
                          ? PasswordStrenght(
                              containLowercase: containLowercase,
                              containDigit: containDigit,
                              hasSpecialCharacter: hasSpecialCharacter,
                              has8Characters: has8Characters,
                              containUppercase: containUppercase)
                          : const SizedBox.shrink(),
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
                            onTap: () => ref.read(signupVM).readPrivacy(),
                            child: RichText(
                              text: TextSpan(
                                text: 'I agree with ',
                                style: GlobalTextStyles.regularText(
                                    context: context),
                                children: [
                                  TextSpan(
                                      text: 'terms',
                                      style: GlobalTextStyles.boldText(
                                          context: context, fontSize: 16)),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                      text: 'policies',
                                      style: GlobalTextStyles.boldText(
                                          context: context, fontSize: 16)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      GlobalButton(
                        title: 'Create account',
                        isDisabled: !checkBoxState,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (checkBoxState) {
                              registerEmail.value.email = emailController.text;
                              registerEmail.value.userType = value.toString();
                              ref.read(signupVM).register(
                                  payload: RegisterModel(
                                    city: '',
                                      fullName: value.toString() != 'user'
                                          ? "${firstNameController.text} ${lastNameController.text}"
                                          : userNameController.text,
                                      email: emailController.text,
                                      isVendor: value.toString() != 'user',
                                      phoneNumber: convertToPhone(
                                          phoneNumberController.text),
                                      credentials: passwordController.text),
                                  context: context);
                            } else {
                              alert(  description:  'Please agree with the terms.');

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
                                      style: GlobalTextStyles.regularGreenText(
                                          context: context)),
                                ],
                              ),
                            ),
                          ),
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

//TODO: REFACTOR THIS TO A BETTER IMPLEMENTATION AFTERWARDS
  checkPasswordStrength(String val) {
    if (val.length >= 11) {
      setState(() {
        has8Characters = true;
      });
    } else {
      setState(() {
        has8Characters = false;
      });
    }
    if (RegExp(r'[0-9]').hasMatch(val)) {
      setState(() {
        containDigit = true;
      });
    } else {
      setState(() {
        containDigit = false;
      });
    }

    if (RegExp(r'[\-_!?#$@&*(){}<>:;@,+$]').hasMatch(val)) {
      setState(() {
        hasSpecialCharacter = true;
      });
    } else {
      setState(() {
        hasSpecialCharacter = false;
      });
    }

    if (RegExp(r'[A-Z]').hasMatch(val)) {
      setState(() {
        containUppercase = true;
      });
    } else {
      setState(() {
        containUppercase = false;
      });
    }

    if (RegExp(r'[a-z]').hasMatch(val)) {
      setState(() {
        containLowercase = true;
      });
    } else {
      setState(() {
        containLowercase = false;
      });
    }
  }
}

class RegisterPayload {
  String? email;
  String? userType;

  RegisterPayload({this.email, this.userType});
}
