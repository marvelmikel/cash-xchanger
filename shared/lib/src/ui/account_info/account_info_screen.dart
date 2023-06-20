
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';

import 'package:sizer/sizer.dart';

class AccountInfoScreen extends ConsumerStatefulWidget {
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends ConsumerState<AccountInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileViewModelProviderV1);
        return Scaffold(
          backgroundColor: GlobalColors.primaryBlack,
          body: Column(
            children: [
              const BackButtonWidget(),
              const SizedBox(height: 20),
              const ProfileImageX(),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding:
                      const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: GlobalColors.globalWhite,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20))),
                  child: Column(
                    children: [
                      BoxEditText(
                        fieldName: 'Profile name',
                        hint: state.currentUser.fullName!,
                        keyBoardType: TextInputType.name,
                      ),
                      const SizedBox(height: 25),
                      BoxEditText(
                        fieldName: 'Email',
                        hint: state.currentUser.email!,
                        keyBoardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 25),
                      BoxEditText(
                        fieldName: 'Phone Number',
                        hint: state.currentUser.phoneNumber!,
                        keyBoardType: TextInputType.phone,
                      ),
                      const Spacer(),
                      GlobalButton(
                        title: 'Edit Profile',
                        onPressed: () {},
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              )
            ],
          ),
        );

  }
}
