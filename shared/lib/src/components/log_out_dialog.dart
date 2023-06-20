import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';
import 'package:sizer/sizer.dart';

class ConfirmLogoutDialog extends ConsumerStatefulWidget {
  const ConfirmLogoutDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<ConfirmLogoutDialog> createState() => _ConfirmLogoutDialogState();
}

class _ConfirmLogoutDialogState extends ConsumerState<ConfirmLogoutDialog> {
  @override
  Widget build(BuildContext context) {
    final navigation = ref.watch(navProvider);
    final profile = ref.watch(profileViewModelProviderV1);
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.center,
        margin:  EdgeInsets.symmetric(vertical: 35.h, horizontal: 5.w),
        padding:  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Do you want to Logout?',
                textAlign: TextAlign.center,
                style: GlobalTextStyles.regularMediumH(fontSize: 16.sp)),
            SizedBox(height: 2.h),
            Text(
              'We will clear your data to ensure safety',
              textAlign: TextAlign.center,
              style: GlobalTextStyles.regularText(fontSize: 12.sp, context: context),
            ),
            SizedBox(height: 3.h),
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
                      navigation.replaceUntil(
                          context: context, routeName: Routes.overViewScreen);
                      profile.resetData();
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
