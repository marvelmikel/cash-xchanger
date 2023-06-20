
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../shared.dart';
import 'models/notifications_model.dart';

class ReadNotificationScreen extends StatelessWidget {
  const ReadNotificationScreen({Key? key, required this.userNotification})
      : super(key: key);

  final UserNotification userNotification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileBackButtonWidget(text: '', isImageVisible: false),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userNotification.title,
                    style: GlobalTextStyles.regularMediumH(fontSize: 20)),
                SizedBox(height: 3.h),
                Text(userNotification.content,
                    style: GlobalTextStyles.regularText(context: context)),
                const SizedBox(height: 10),
                Text(userNotification.notificationDate,
                    style: GlobalTextStyles.regularText(
                        context: context, fontSize: 12, alpha: 100)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
