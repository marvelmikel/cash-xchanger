import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../database/models/notifications_model/notification_model.dart';
import '../service.dart';

abstract class NotificationService {
  Future<List<UserNotification>> getNotifications(
      {required String email, required BuildContext context});

  Future<void> markAsRead({required String notificationRef});
}

class NotificationServiceImp extends NotificationService {
  late Response _response;

  NotificationServiceImp();

  @override
  Future<List<UserNotification>> getNotifications(
      {required String email, required BuildContext context}) async {
    try {
      final uri = Uri.https(cxHead, '/notifications/all/transactions/$email', {
        'MasterAPIKey': 'Qpieg2eKkXSAU1FCK7agQu2ohaT2YHHiLNHjE4BoQmvhQxIRKkg6F'
      });
      _response = await client
          .get(uri, headers: header)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        throw TimeoutException(errorMessage);
      });

      if (_response.statusCode == 200) {
        debugPrint('Fetched notifications');
        Fluttertoast.showToast(msg: 'Fetched notifications');
        return notificationModelFromMap(_response.body).userNotifications;
      } else {
        Fluttertoast.showToast(msg: 'Unable to fetch notifications');
      }
    } catch (_) {
      debugPrint('Error fetching notifications: \n$_');
      return [];
    }
    return [];
  }

  @override
  Future<void> markAsRead({required String notificationRef}) async {
    try {
      final uri = Uri.https(
          cxHead, '/notifications/transactions/read/$notificationRef', {
        'MasterAPIKey': 'Qpieg2eKkXSAU1FCK7agQu2ohaT2YHHiLNHjE4BoQmvhQxIRKkg6F'
      });
      _response = await client
          .get(uri, headers: header)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        var errorMessage = 'The connection timed out, please try again';
        throw TimeoutException(errorMessage);
      });
      debugPrint('Notification marked as read');
    } catch (_) {
      debugPrint('Error fetching notifications: \n$_');
    }
  }
}
