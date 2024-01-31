// notification_helper.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  // Androidの初期化設定
  var initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  // iOSの初期化設定
  var initializationSettingsIOS = DarwinInitializationSettings();

  // // macOSの初期化設定
  // var initializationSettingsMacOS = MacOSInitializationSettings();

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    // macOS: initializationSettingsMacOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}

Future<void> showNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    // 'your_channel_description',
    importance: Importance.high,
    priority: Priority.high,
  );
  // var initializationSettingsMacOS = MacOSInitializationSettings();

  var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
    // macOS: initializationSettingsMacOS,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'ドリカムダイアリー',
    '怠けてないで活動しよう',
    platformChannelSpecifics,
  );
}
