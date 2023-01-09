import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:vibration/vibration.dart';

class NotificationHelper {
  static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const _notificationChannelId = 'store_navigation_route';
  static const _notificationChannelName = 'Routing notifications';

  static Future<void> setup() async {
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSetting = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidSetting, iOS: iosSetting);

    await _localNotificationsPlugin.initialize(initSettings).then((_) {
      log('Flutter local notifications plugin started');
    }).catchError((Object error) {
      throw Exception('Could not start local notifications plugin');
    });

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(_notificationChannelId, _notificationChannelName));
  }

  static int _notificationIndex = 0;
  static Future<void> notify({required String title, required String body}) async {
    if (isInForeground && (await Vibration.hasVibrator() ?? false)) {
      return _notifyForeground(title: title, body: body);
    }

    return _notifyBackground(title: title, body: body);
  }

  static Future<void> _notifyForeground({required String title, required String body}) async {
    await Vibration.vibrate(pattern: [0, 100, 125, 100]);
  }

  static Future<void> _notifyBackground({required String title, required String body}) async {
    await _localNotificationsPlugin.show(
      _notificationIndex++,
      title,
      body,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(interruptionLevel: InterruptionLevel(1)),
        android: AndroidNotificationDetails(
          _notificationChannelId,
          _notificationChannelName,
          importance: Importance.defaultImportance,
        ),
      ),
    );
  }
}
