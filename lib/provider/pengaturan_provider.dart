import 'package:KuyMinum/config/notification_service.dart';
import 'package:KuyMinum/config/view_state.dart';
import 'package:KuyMinum/locator.dart';
import 'package:KuyMinum/provider/base_provider.dart';
import 'package:KuyMinum/provider/login_provider.dart';
import 'package:KuyMinum/service/data_harian_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengaturanProvider extends BaseProvider {

  List<String> list = [
    '5 Menit',
    '60 Menit (Default)',
    '90 Menit',
    '120 Menit'
  ];
  List<int> listInt = [
    5, 60, 90, 120
  ];
  String selected = '60 Menit (Default)';

  int notifikasi = 60;
  // NotificationService ns = NotificationService();

  Future init() async{
    setState(ViewState.Fetching);
    SharedPreferences sh = await SharedPreferences.getInstance();
    if(sh.containsKey('menit-teks-notifikasi')){
      selected = await sh.getString('menit-teks-notifikasi');
    }
    print(selected);
    setState(ViewState.Idle);
  }

  void ubahNotifikasi() async {
    int menit;
    if(selected=='5 Menit'){
      menit = 5;
    } else if(selected=='60 Menit (Default)'){
      menit = 60;
    } else if(selected=='90 Menit'){
      menit = 90;
    } else if(selected=='120 Menit'){
      menit = 120;
    } else {
      menit = 60;
    }
    ubah(menit);
  }

  void ubah(int menit) async {
    print('ubah $menit');
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setInt('menit-notifikasi', menit);
    sh.setString('menit-teks-notifikasi', selected);
  }

  Future keluar() async{
    locator<LoginProvider>().signOutFromGoogle();
    SharedPreferences sh = await SharedPreferences.getInstance();
    print("keluar");
    sh.clear();
  }
}
