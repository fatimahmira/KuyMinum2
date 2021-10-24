import 'dart:convert';

import 'package:KuyMinum/data/data.dart';
import 'package:KuyMinum/provider/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PilihGelasProvider extends BaseProvider{
  Data data = Data();
  var gelas = [];

  void initGelas() async{
    try{
      SharedPreferences sh = await SharedPreferences.getInstance();

      gelas = data.dataGelas;
      print("init");

      if (sh.containsKey('gelas')) {
        var glas = await sh.getString('gelas');
        gelas = jsonDecode(glas);
      }
      notifyListeners();
    } catch (e){
      print(e.toString());
    }
  }

  void gelasSelected(var gelasSelected) async{
    SharedPreferences sh = await SharedPreferences.getInstance();

    await sh.setString('gelas', jsonEncode(gelas).toString());
    // print("gelas $gelas");

    await sh.setString('gelas-selected', jsonEncode(gelasSelected).toString());
    // print("gelas-selected $gelasSelected");

  }
}