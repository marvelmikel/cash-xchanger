
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../ui.dart';


class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Password'),
        centerTitle: true,
        actions: [
          MenuFiller(
            icon: Icons.menu,
            onClick: () {},
            color: GlobalColors.lightGreen,
            bgColor: Colors.transparent,
            size: 30,
          ),
        ],
      ),
      body: Container(
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
                    title: 'Change password',

                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // getItInstance<ProfileCubit>().changePassword(
                        //     previousPassword: oldPasswordController.text,
                        //     newPassword: newPasswordController.text,
                        //     context: context);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
