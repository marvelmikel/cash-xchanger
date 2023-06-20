import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared.dart';
import 'models/notifications_model.dart';
import 'notifications_vm.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationsVM);

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
                            index: index,
                            userNotification:
                                state.listOfNotifications[index])),
                  )
      ],
    ));
  }
}

class NotificationItem extends ConsumerWidget {
  const NotificationItem({
    Key? key,
    required this.userNotification,
    required this.index,
  }) : super(key: key);

  final UserNotification userNotification;

  final int index;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(notificationsVM);
    final navigation = ref.watch(navProvider);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          state.markNotificationAsRead(
              notificationRef: userNotification.reference);
          navigation.navigateTo(Routes.readNotificationScreen,
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
                          style: GlobalTextStyles.boldText(
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
