import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/helpers.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/navigation/navigation_service.dart';
import 'package:cash_xchanger/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'confirm_log_out_dailog.dart';
import 'nav_menu_item.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Drawer(
          child: Material(
            color: GlobalColors.primaryBlue,
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
                      SizedBox(height: GlobalSizes.globalHeight(context, 0.05)),
                      Row(
                        children: [
                          profileImage(context: context),
                          SizedBox(
                              width: GlobalSizes.globalWidth(context, 0.06)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${state.profileModel?.userDetails.firstName ?? "John"} ${state.profileModel?.userDetails.lastName ?? "Doe"}',
                                style: GlobalTextStyles.regularTextWhite(
                                    context: context),
                              ),
                              Text(
                                state.profileModel?.userDetails.email ??
                                    'john@doe.com',
                                style: GlobalTextStyles.regularGreenText(
                                    context: context, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      NavMenuItem(
                        menuImage: 'person_icon.svg',
                        menuTitle: 'Account Info',
                        menuSubTitle: 'Profile name, photo',
                        onTap: () {
                          Navigator.pop(context);
                          getItInstance<NavigationServiceImpl>()
                              .navigateTo(Routes.accountInfoScreen);
                        },
                      ),
                      state.profileModel?.userDetails.userRole == 'user'
                          ? NavMenuItem(
                              menuImage: 'calendar_icon.svg',
                              menuTitle: 'Scheduled cash orders',
                              menuSubTitle: 'Your scheduled orders',
                              onTap: () {
                                Navigator.pop(context);
                                getItInstance<NavigationServiceImpl>()
                                    .navigateTo(Routes.scheduledTransfers);
                              },
                            )
                          : const SizedBox.shrink(),
                      NavMenuItem(
                        menuImage: 'bell_icon.svg',
                        menuTitle: 'Notifications',
                        menuSubTitle: 'Updates and alerts',
                        onTap: () {
                          Navigator.pop(context);
                          getItInstance<NavigationServiceImpl>().navigateTo(
                              Routes.notificationScreen,
                              arguments: state.profileModel!.userDetails.email);
                        },
                      ),
                      NavMenuItem(
                        menuImage: 'card_icon.svg',
                        menuTitle: 'Payment methods',
                        menuSubTitle: 'Cards and payments',
                        onTap: () {
                          Navigator.pop(context);
                          getItInstance<NavigationServiceImpl>()
                              .navigateTo(Routes.paymentMethods);
                        },
                      ),
                      NavMenuItem(
                        menuImage: 'settings_icon.svg',
                        menuTitle: 'Settings',
                        menuSubTitle: 'Notifications, Password',
                        onTap: () {
                          Navigator.pop(context);
                          getItInstance<NavigationServiceImpl>()
                              .navigateTo(Routes.verifyPasswordScreen);
                        },
                      ),
                      const SizedBox(height: 80),
                      NavMenuItem(
                        menuImage: 'log_out_button.svg',
                        menuTitle: 'Log out',
                        menuSubTitle: 'Signs you out of the App',
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  const ConfirmLogoutDialog());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
