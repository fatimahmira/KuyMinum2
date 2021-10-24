import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app');
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //     0,
    //     'Jangan Lupa Minum!',
    //     'klik untuk minum',
    //     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    //     const NotificationDetails(
    //         android: AndroidNotificationDetails('your channel id',
    //             'your channel name', 'your channel description',
    //         enableVibration: true,
    //         priority: Priority(1),)),
    //     androidAllowWhileIdle: true,
    //     uiLocalNotificationDateInterpretation:
    //     UILocalNotificationDateInterpretation.absoluteTime);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('repeating channel id',
            'repeating channel name', 'repeating description',
            icon: 'app',
        playSound: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('air'),
        priority: Priority(1));
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Saatnya minum air..',
        'Klik untuk konfirmasi kamu sudah minum hari ini :)',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
        notificationDetails,
        androidAllowWhileIdle: true,);
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }

  // Future onSelectNotification(String payload) async {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       return new AlertDialog(
  //         title: Text("PayLoad"),
  //         content: Text("Payl-p0fdoad : $payload"),
  //       );
  //     },
  //   );
  // }
}
