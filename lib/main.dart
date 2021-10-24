import 'dart:isolate';

import 'package:KuyMinum/config/notification_service.dart';
import 'package:KuyMinum/config/router.dart';
import 'package:KuyMinum/locator.dart';
import 'package:KuyMinum/view/halaman_minum.dart';
import 'package:KuyMinum/view/home.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  int notifikasi;
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AndroidAlarmManager.initialize();
  SharedPreferences sh = await SharedPreferences.getInstance();
  if(sh.containsKey('menit-notifikasi')){
    notifikasi = sh.getInt('menit-notifikasi');
  } else {
    notifikasi = 60;
  }
  await AndroidAlarmManager.periodic(Duration(minutes: notifikasi), 0, doNotification);
  // await NotificationProvider().initNotif();
  // await initNotif();
  runApp(MyApp());
}

Future<void> initNotif() async {
  int menit = 1;
  SharedPreferences sh = await SharedPreferences.getInstance();
  if (sh.containsKey('menit-notifikasi')) {
    menit = await sh.getInt('menit-notifikasi');
  }
  print("menit $menit");
  await AndroidAlarmManager.periodic(
      Duration(minutes: menit), 0, doNotification);
}

Future<void> doNotification() async {
  print("do the notification");
  await NotificationService().init();
}

class MyApp extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        onGenerateRoute: AppRouter().onGenerateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: user != null ? HalamanMinum() : Home());
  }
}
