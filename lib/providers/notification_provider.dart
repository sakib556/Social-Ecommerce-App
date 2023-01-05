import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/models/notification/notification.dart';
import 'package:protibeshi_app/state_notfiers/notification_notifier.dart';


final notificationProvider =
    StateNotifierProvider<NotificationNotifier, ApiState<String>>(
        (ref) => NotificationNotifier());
final getNotificationProvider =
    StateNotifierProvider<GetNotificationNotifier, ApiState<List<NotificationModel>>>(
        (ref) => GetNotificationNotifier());

class NotificationProvider {
  // Removed extends ChangeNotifier Don't Think Its Needed
  static Future<void> addDeviceTokens() async {
    print("Ran");
    final _token = await FirebaseMessaging.instance.getToken();
    if (_token != null) {
      await FirebaseConstants.userDeviceTokensRef(
              FirebaseAuth.instance.currentUser!.uid, _token)
          .set(true);
    }
  }

  static Future<void> removeDeviceTokens() async {
    final _token = await FirebaseMessaging.instance.getToken();
    if (_token != null) {
      await FirebaseConstants.userDeviceTokensRef(
              FirebaseAuth.instance.currentUser!.uid, _token)
          .remove();
    }
  }
}

