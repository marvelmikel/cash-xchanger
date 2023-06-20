import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/ui/login_screen/models/login_model.dart';
import 'package:shared/src/ui/login_screen/viewmodel/login_vm.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  GlobalKey<FormState> globalKey = GlobalKey();

  final emailController = TextEditingController(text: "tefekap700@pyadu.com");

  final passwordController = TextEditingController(text: "md5Asdf#24kt");

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
                Text('Log in',
                    style: GlobalTextStyles.boldText(
                        context: context, fontSize: 32)),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.17)),
                Text(
                  'Please enter your details to continue.',
                  style: GlobalTextStyles.regularText(context: context),
                ),
                GlobalTextField(
                    fieldName: 'Email address',
                    keyBoardType: TextInputType.emailAddress,
                    textController: emailController),
                GlobalTextField(
                    fieldName: 'Password',
                    obscureText: true,
                    isEyeVisible: true,
                    removeSpace: false,
                    keyBoardType: TextInputType.text,
                    textController: passwordController),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.05)),
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
                              color: checkBoxState
                                  ? GlobalColors.primaryBlack
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color:
                                      GlobalColors.primaryBlack.withAlpha(80),
                                  width: 2)),
                          child: checkBoxState
                              ? SvgPicture.asset('assets/images/tick_icon.svg',
                                  height: 15)
                              : const SizedBox.shrink()),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      radius: 10,
                      onTap: () =>
                          setState(() => checkBoxState = !checkBoxState),
                      child: Text(
                        'Remember me',
                        style: GlobalTextStyles.regularText(context: context),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size(18.w, 0),
                    ),
                    InkWell(
                      // onTap: () => getItInstance<NavigationServiceImpl>()
                      //     .navigateTo(Routes.initReset),
                      child: Text(
                        'Forgot password',
                        style:
                            GlobalTextStyles.regularGreenText(context: context),
                      ),
                    )
                  ],
                ),
                SizedBox(height: GlobalSizes.globalWidth(context, 0.09)),
                GlobalButton(
                    title: 'Login',
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        ref.read(loginVM).login(
                            payload: LoginModel(
                                username: emailController.text,
                                credentials: passwordController.text),
                            context: context);
                        // getItInstance<LoginCubit>().login(
                        //     context: context,
                        //     payload: LoginModel(
                        //         username: emailController.text,
                        //         credentials: passwordController.text));
                      }
                    }),
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
