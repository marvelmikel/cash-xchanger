import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';
import 'package:sizer/sizer.dart';

import '../../../../user.dart';

class UserNavigationDrawer extends ConsumerStatefulWidget {
  const UserNavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<UserNavigationDrawer> createState() =>
      _UserNavigationDrawerState();
}

class _UserNavigationDrawerState extends ConsumerState<UserNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileViewModelProviderV1);
    final navigation = ref.watch(navProvider);
    return Drawer(
      child: Material(
        color: GlobalColors.primaryBlack,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close,
                            size: 25, color: GlobalColors.primaryGreen),
                      )),
                  Row(
                    children: [
                      const ProfileImage(),
                      SizedBox(width: GlobalSizes.globalWidth(context, 0.06)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.currentUser.fullName ?? 'John Doe',
                            style: GlobalTextStyles.regularTextWhite(
                                context: context, fontSize: 12.sp),
                          ),
                          Text(
                            profile.currentUser.email ?? 'john@doe.com',
                            style: GlobalTextStyles.regularGreenText(
                                context: context, fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    height: 6.h,
                    color: GlobalColors.lightGreen,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Become a vendor today!',
                          style: GlobalTextStyles.regularTextWhite(
                              context: context, fontSize: 11.sp),
                        ),
                        Container(
                          width: 15.3.w,
                          height: 3.5.h,
                          decoration: BoxDecoration(
                              color: GlobalColors.primaryBlack,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Center(
                            child: Text(
                              'Sign up',
                              style: GlobalTextStyles.regularTextWhite(
                                  context: context, fontSize: 13),
                            ),
                          ),
                        )
                        //   Globa//lButton(buttonText: 'Switch', onTap: (){}, width: 20,)
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  NavMenuItem(
                    menuImage: 'home_icon.svg',
                    menuTitle: 'Home',
                    menuSubTitle: 'Request cash',
                    onTap: () {
                      Navigator.pop(context);
                      // getItInstance<NavigationServiceImpl>()
                      //     .navigateTo(Routes.accountInfoScreen);
                    },
                  ),
                  NavMenuItem(
                    menuImage: 'person_icon.svg',
                    menuTitle: 'Account Info',
                    menuSubTitle: 'Profile name, photo',
                    onTap: () {
                      Navigator.pop(context);
                      navigation.navigateTo(Routes.accountInfoScreen);
                    },
                  ),
                  NavMenuItem(
                    menuImage: 'transaction_icon.svg',
                    menuTitle: 'Transaction history',
                    menuSubTitle: 'Amount, date, status',
                    onTap: () {
                      Navigator.pop(context);
                      navigation.navigateTo(Routes.transactionScreen);
                    },
                  ),
                  NavMenuItem(
                    menuImage: 'bell_icon.svg',
                    menuTitle: 'Notifications',
                    menuSubTitle: 'Updates and alerts',
                    onTap: () {
                      Navigator.pop(context);
                      navigation.navigateTo(Routes.notificationScreen,
                          arguments: profile.currentUser.email ??
                              'john.d2021@yahoo.com');
                    },
                  ),
                  NavMenuItem(
                    menuImage: 'card_icon.svg',
                    menuTitle: 'Payment methods',
                    menuSubTitle: 'Cards and payments',
                    onTap: () {
                      Navigator.pop(context);
                      navigation.navigateTo(Routes.paymentMethods, arguments: PaymentType.card);
                    },
                  ),
                  NavMenuItem(
                    menuImage: 'promotion_icon.svg',
                    menuTitle: 'Promotion',
                    menuSubTitle: 'Referral link, promo code',
                    onTap: () {
                      Navigator.pop(context);
                      navigation.navigateTo(Routes.promotionsScreen);
                    },
                  ),
                  NavMenuItem(
                    menuImage: 'support_icon.svg',
                    menuTitle: 'Contact support',
                    menuSubTitle: 'Notifications, Password',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  NavMenuItem(
                    menuImage: 'settings_icon.svg',
                    menuTitle: 'Settings',
                    menuSubTitle: 'Notifications, Password',
                    onTap: () {
                      Navigator.pop(context);
                      navigation.navigateTo(Routes.settingsScreen);
                      // getItInstance<NavigationServiceImpl>()
                      //     .navigateTo(Routes.verifyPasswordScreen);
                    },
                  ),
                  SizedBox(height: 4.h),
                  NavMenuItem(
                    menuImage: 'log_out_button.svg',
                    menuTitle: 'Log out',
                    menuSubTitle: 'Signs you out of the App',
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) => const ConfirmLogoutDialog());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
