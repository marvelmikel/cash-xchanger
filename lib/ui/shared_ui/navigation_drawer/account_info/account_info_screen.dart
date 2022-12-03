import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/ui/global_widgets/back_button.dart';
import 'package:cash_xchanger/ui/global_widgets/box_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: GlobalColors.primaryBlue,
          body: Column(
            children: [
              const BackButtonWidget(),
              const SizedBox(height: 20),
              profileImageX(context: context, email: state.profileModel!.userDetails.email),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: GlobalColors.globalWhite,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: BoxEditText(
                              fieldName: 'Firstname',
                              hint: state.profileModel!.userDetails.firstName,
                              keyBoardType: TextInputType.name,
                            ),
                          ),
                          const SizedBox(width: 25),
                          Expanded(
                            child: BoxEditText(
                              fieldName: 'Lastname',
                              hint: state.profileModel!.userDetails.lastName,
                              keyBoardType: TextInputType.name,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      BoxEditText(
                        fieldName: 'Username',
                        hint: state.profileModel!.userDetails.username,
                        keyBoardType: TextInputType.name,
                      ),
                      const SizedBox(height: 25),
                      BoxEditText(
                        fieldName: 'Email',
                        hint: state.profileModel!.userDetails.email,
                        keyBoardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 25),
                      BoxEditText(
                        fieldName: 'Phone Number',
                        hint: state.profileModel!.userDetails.phoneNumber,
                        keyBoardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
