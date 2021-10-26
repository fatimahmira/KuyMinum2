
import 'dart:convert';

import 'package:KuyMinum/config/view_state.dart';
import 'package:KuyMinum/locator.dart';
import 'package:KuyMinum/model/daftar_data_tanggal_model.dart';
import 'package:KuyMinum/model/data_harian_model.dart';
import 'package:KuyMinum/provider/base_provider.dart';
import 'package:KuyMinum/provider/login_provider.dart';
import 'package:KuyMinum/service/data_harian_services.dart';

class DataHarianProvider extends BaseProvider{
  // List<DataHarian> dataHarians;
  DaftarDataTanggal listTanggal;
  List<DataJam> dataMinum;
  List<List<DaftarDataHarian>> listData;
  DataHarianServices dataHarianServices = DataHarianServices();

  void init() async{
    try{
      setState(ViewState.Fetching);
      listTanggal = await dataHarianServices.getAllData();
      if(listTanggal.data.isEmpty){
        print("kosong");
        setState(ViewState.FetchNull);
      } else {
        print("gak kosong");
        setState(ViewState.Idle);
      }
      // print(jsonEncode(listTanggal).toString());

    } catch(e){
      print(e.toString());
    }

  }

  void hapus(){
    dataHarianServices.deleteAllData();
    notifyListeners();
  }

  // Future fetchDataHarian() async{
  //   try{
  //     setState(ViewState.Fetching);
  //
  //     List<DataHarian> dataHarian = await DataHarianServices().fetchData();
  //     dataHarians = dataHarian;
  //     print(dataHarian.toString());
  //     setState(ViewState.Idle);
  //     // return dataHarian;
  //   } catch (e){
  //     throw e;
  //   }
  // }

  // Future create() async{
  //   try{
  //     setState(ViewState.Fetching);
  //
  //     List<DataHarian> dataHarian = await DataHarianServices().fetchData();
  //     dataHarians = dataHarian;
  //     print(dataHarian.toString());
  //     setState(ViewState.Idle);
  //     // return dataHarian;
  //   } catch (e){
  //     throw e;
  //   }
  // }

  // Future delete() async{
  //   try{
  //     setState(ViewState.Fetching);
  //
  //     await DataHarianServices().deleteData();
  //
  //     setState(ViewState.Idle);
  //     // return dataHarian;
  //   } catch (e){
  //     throw e;
  //   }
  // }
}