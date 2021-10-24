import 'dart:convert';
import 'dart:io';

import 'package:KuyMinum/model/data_harian_model.dart';
import 'package:KuyMinum/service/Service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataHarianServices extends Service{
  Future<Response> createMinum(var data) async {
    try {
      var url = '/simpan';

      var response = await post(url, data);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw ('data tidak ditemukan');
      }
    } on SocketException catch (_) {
      throw SocketException('no_internet');
    } catch (error) {
      if (error is DioError) {
        print(error.response.statusCode);
        throw (error.response.statusCode);
      }
    }
  }

  Future getDataToday() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();

      var url = '/hariini';

      var tkn = await sh.getString("token");
      var token = {
        "token" : tkn
      };

      var response = await post(url, token);

      if (response.statusCode == 200) {
        print(response.data);
        DaftarDataHarian dataHarian = daftarDataHarianFromJson(jsonEncode(response.data));
        return dataHarian;
      } else {
        throw ('data tidak ditemukan');
      }

      if (response.statusCode == 200) {
        return response;
      } else {
        throw ('data tidak ditemukan');
      }
    } on SocketException catch (_) {
      throw SocketException('no_internet');
    } catch (error) {
      if (error is DioError) {
        print(error.response.statusCode);
        throw (error.response.statusCode);
      }
    }
  }

  Future getAllData(var data) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();

      var url = '/hariini';

      var tkn = await sh.getString("token");
      var token = {
        "token" : tkn
      };
      var response = await post(url, data);
      print(data);
      if (response.statusCode == 200) {
        print(response.data);
        DaftarDataHarian dataHarian = daftarDataHarianFromJson(jsonEncode(response.data));
        return dataHarian;
      } else {
        throw ('data tidak ditemukan');
      }

      if (response.statusCode == 200) {
        return response;
      } else {
        throw ('data tidak ditemukan');
      }
    } on SocketException catch (_) {
      throw SocketException('no_internet');
    } catch (error) {
      if (error is DioError) {
        print(error.response.statusCode);
        throw (error.response.statusCode);
      }
    }
  }
}