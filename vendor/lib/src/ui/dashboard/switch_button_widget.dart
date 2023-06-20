import 'package:core/core.dart';
import 'package:flutter/material.dart';

var isUserOnline = ValueNotifier(false);

class SwitchButtonWidget extends StatefulWidget {
  const SwitchButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SwitchButtonWidget> createState() => _SwitchButtonWidgetState();
}

class _SwitchButtonWidgetState extends State<SwitchButtonWidget> {
  @override
  Widget build(BuildContext context) {
    // Timer? countdownTimer;

    return ValueListenableBuilder(
        valueListenable: isUserOnline,
        builder: (context, bool isOnline, child) {
          return Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                isOnline
                    ? Text('Online',
                        style: GlobalTextStyles.blueMediumText(
                            context: context, fontSize: 20))
                    : Text('Offline',
                        style: GlobalTextStyles.blueMediumText(
                            context: context, fontSize: 20)),
                GestureDetector(
                  // onTap: () => getItInstance<VendorCubit>()
                  //     .changeOnlineStatus(context: context),
                  // tempUser.isUserOnline
                  //     ? VendorOnline()
                  //         .isOffLine(cash_type: 'mint', context: context)
                  //     : showDialog(
                  //         context: context,
                  //         builder: (context) => OnlineVendorCashType()),
                  // tempProfile.put(
                  //     'userProfile',
                  //     ProfileModel(
                  //         email: tempUser.email,
                  //         firstName: tempUser.firstName,
                  //         lastName: tempUser.lastName,
                  //         profilePic: tempUser.profilePic,
                  //         userName: tempUser.userName,
                  //         role: tempUser.role,
                  //         isPinSet: tempUser.isPinSet,
                  //         phoneNumber: tempUser.phoneNumber,
                  //         isUserOnline: tempUser.isUserOnline,
                  //         isDocVerified: tempUser.isDocVerified))

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    width: 55,
                    height: 25,
                    decoration: BoxDecoration(
                        color: isOnline
                            ? GlobalColors.primaryGreen
                            : GlobalColors.primaryBlack.withAlpha(50),
                        borderRadius: BorderRadius.circular(20)),
                    child: Align(
                      alignment: isOnline
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                            color: GlobalColors.globalWhite,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
