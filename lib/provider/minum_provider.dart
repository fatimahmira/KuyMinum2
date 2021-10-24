import 'dart:convert';

import 'package:KuyMinum/config/view_state.dart';
import 'package:KuyMinum/data/data.dart';
import 'package:KuyMinum/model/data_harian_model.dart';
import 'package:KuyMinum/provider/base_provider.dart';
import 'package:KuyMinum/service/data_harian_services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locator.dart';

class MinumProvider extends BaseProvider {
  Data data = Data();
  // DateTime now = new DateTime.now();
  bool visible = false;
  bool visibleList = false;
  DataHarianServices dataHarianServices = locator<DataHarianServices>();

  Map<String, double> dataMap = {
    "minum": 0,
    "belum-minum": 2000,
  };

  var gelas;
  var listGelas;
  DaftarDataHarian riwayatMinum;
  double targetMinum = 2000;
  double minum = 0.0;

  void initMinum() async {
    setState(ViewState.Fetching);

    gelas = data.dataGelas[0];
    listGelas = data.dataGelas;
    // riwayatMinum = data.dataMinum;

    try{
      SharedPreferences sh = await SharedPreferences.getInstance();
      print("init");

      if (sh.containsKey('gelas')) {
        var glas = await sh.getString('gelas');
        listGelas = jsonDecode(glas);
      }

      if (sh.containsKey('minum')) {
        minum = await double.parse(sh.getString('minum'));
      }
      dataMap['minum'] = minum;

      if (sh.containsKey('gelas-selected')) {
        var glas = await sh.getString('gelas-selected');
        gelas = jsonDecode(glas);
        print("ada");
        print(gelas);
      }

      // if (sh.containsKey('riwayat-minum')) {
      //   var rm = await sh.getString('riwayat-minum');
      //   riwayatMinum = jsonDecode(rm);
      // }
      var tkn = await sh.getString("token");
      var token = {
        "token" : tkn
      };
      // riwayatMinum = await DataHarianServices().getDataToday(token);

      riwayatMinum = await dataHarianServices.getDataToday(token);
      if(riwayatMinum.data.isEmpty){
        print("kosong");
        setState(ViewState.FetchNull);
      } else {
        setState(ViewState.Idle);

      }
      // print(riwayatMinum);

      notifyListeners();

    } catch (e){
      print(e.toString());
    }

  }

  void minum100ml() async {
    //set minum hari ini
    SharedPreferences sh = await SharedPreferences.getInstance();

    minum += gelas['method'];
    dataMap['minum'] = minum;
    dataMap['belum-minum'] = targetMinum - minum;

    sh.setString('minum', minum.toString());

    // set riwayat
    var tkn = await sh.getString("token");
    var minumlu = {
      'gambar' : gelas['gelas'].toString(),
      'ukuran' : gelas['ukuran'].toString(),
      'token' : tkn
    };
    dataHarianServices.createMinum(minumlu);
    var token = {
      "token" : tkn
    };
    riwayatMinum = await dataHarianServices.getDataToday(token);
    print("minumlu $minumlu");
    print("riwayatMinum $riwayatMinum");
    // locator<FirestoreProvider>().createOrUpdate(
    //   ukuran: gelas['ukuran'].toString(),
    //   jam: "${DateFormat.Hm().format(DateTime.now())}",
    //   gambar: gelas['gelas'].toString()
    // );

    // riwayatMinum = await DataHarianServices().getDataToday();

    // sh.setString('riwayat-minum', jsonEncode(riwayatMinum));
    notifyListeners();
  }

  void initGelas() async{
    listGelas = data.dataGelas;

    try{
      SharedPreferences sh = await SharedPreferences.getInstance();

      print("init");

      if (sh.containsKey('gelas')) {
        var glas = await sh.getString('gelas');
        listGelas = jsonDecode(glas);
      }
      notifyListeners();
    } catch (e){
      print(e.toString());
    }
  }

  void gelasSelected(var gelasSelected) async{
    SharedPreferences sh = await SharedPreferences.getInstance();

    await sh.setString('gelas', jsonEncode(listGelas).toString());
    // print("gelas $gelas");

    await sh.setString('gelas-selected', jsonEncode(gelasSelected).toString());
    // print("gelas-selected $gelasSelected");
    gelas = gelasSelected;
    print(gelas);
    notifyListeners();
  }
}
