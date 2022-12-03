import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/navigation/navigation_service.dart';
import 'package:cash_xchanger/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmLogoutDialog extends StatefulWidget {
  const ConfirmLogoutDialog({Key? key}) : super(key: key);

  @override
  State<ConfirmLogoutDialog> createState() => _ConfirmLogoutDialogState();
}

class _ConfirmLogoutDialogState extends State<ConfirmLogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 280, horizontal: 50),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Do you want to Logout?',
                textAlign: TextAlign.center,
                style: GlobalTextStyles.regularMediumH(fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              'We will clear your data to ensure safety',
              textAlign: TextAlign.center,
              // style: GlobalTextStyles.regularText(fontSize: 12),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: GlobalColors.primaryBlue),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('Cancel',
                          style:
                              GlobalTextStyles.regularText(context: context)),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      getItInstance<NavigationServiceImpl>().replaceUntil(
                          context: context, routeName: Routes.overViewScreen);
                      context.read<ProfileCubit>().resetData();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: GlobalColors.primaryBlue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('Log out',
                          style: GlobalTextStyles.regularMediumWhite()),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
