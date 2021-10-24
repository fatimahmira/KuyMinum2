import 'package:KuyMinum/config/notification_service.dart';
import 'package:KuyMinum/provider/base_provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationProvider extends BaseProvider{

  Future<void> initNotif() async {
    int menit = 1;
    SharedPreferences sh = await SharedPreferences.getInstance();
    if(sh.containsKey('menit-notifikasi')){
      menit = await sh.getInt('menit-notifikasi');
    }
    print("menit $menit");
    await AndroidAlarmManager.periodic(Duration(minutes: menit), 0, doNotification);
  }


  Future<void> doNotification() async {
    print("do the notification");
    await NotificationService().init();
  }

}