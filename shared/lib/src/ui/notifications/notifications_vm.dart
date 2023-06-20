

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/src/ui/notifications/models/notifications_model.dart';

final notificationsVM = ChangeNotifierProvider((ref) => NotificationsVM(ref));

class NotificationsVM extends ChangeNotifier{

  final Ref ref;

  var isLoading = false;
  NotificationsVM(this.ref);

 late List<UserNotification> listOfNotifications = <UserNotification>[];

  void markNotificationAsRead({required String notificationRef}) {}
}