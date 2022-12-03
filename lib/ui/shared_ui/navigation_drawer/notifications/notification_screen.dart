import 'package:cash_xchanger/cubit/nav_bar_cubit/nav_drawer_cubit.dart';
import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/helpers/colors.dart';
import 'package:cash_xchanger/helpers/sizes.dart';
import 'package:cash_xchanger/helpers/text_styles.dart';
import 'package:cash_xchanger/navigation/navigation_service.dart';
import 'package:cash_xchanger/navigation/routes.dart';
import 'package:cash_xchanger/ui/global_widgets/global_shimmer_loader.dart';
import 'package:cash_xchanger/ui/global_widgets/profile_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../database/models/notifications_model/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<NavDrawerCubit>().getNotifications(context: context);
    return BlocBuilder<NavDrawerCubit, NavDrawerState>(
      builder: (context, state) {
        return Scaffold(
            body: Column(
          children: [
            const ProfileBackButtonWidget(
                text: 'Notifications', isImageVisible: false),
            state.isLoading
                ? GlobalShimmerLoader()
                : state.listOfNotifications.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(height: 10),
                              SvgPicture.asset('assets/images/no_card.svg',
                                  height: 70),
                              const SizedBox(height: 10),
                              const Text('No recent notifications')
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: state.listOfNotifications.length,
                            itemBuilder: (context, index) => NotificationItem(
                                email: widget.email,
                                index: index,
                                userNotification:
                                    state.listOfNotifications[index])),
                      )
          ],
        ));
      },
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.userNotification,
    required this.email,
    required this.index,
  }) : super(key: key);

  final UserNotification userNotification;
  final String email;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          context.read<NavDrawerCubit>().markNotificationAsRead(
              email: email,
              context: context,
              notificationRef: userNotification.reference);
          getItInstance<NavigationServiceImpl>().navigateTo(
              Routes.readNotificationScreen,
              arguments: userNotification);
        },
        child: Container(
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: userNotification.status ? Colors.grey : Colors.transparent,
            backgroundBlendMode: BlendMode.saturation,
          ),
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
              color: GlobalColors.globalWhite,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              userNotification.notificationType == 'purchase'
                  ? SvgPicture.asset('assets/images/history_airtime_icon.svg',
                      height: 40)
                  : userNotification.notificationType == 'book_cash'
                      ? SvgPicture.asset(
                          'assets/images/history_cash_request_icon.svg',
                          height: 40)
                      : userNotification.notificationType == 'new_cash_request'
                          ? SvgPicture.asset(
                              'assets/images/history_wallet_balance_icon.svg',
                              height: 40)
                          : SvgPicture.asset(
                              'assets/images/history_wallet_icon.svg',
                              height: 40),
              SizedBox(width: GlobalSizes.globalWidth(context, 0.03)),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userNotification.title,
                          style: GlobalTextStyles.blueBoldText(
                              context: context, fontSize: 14)),
                      SizedBox(height: GlobalSizes.globalWidth(context, 0.005)),
                      Text(userNotification.title,
                          style: GlobalTextStyles.regularText(
                              context: context, fontSize: 14)),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
