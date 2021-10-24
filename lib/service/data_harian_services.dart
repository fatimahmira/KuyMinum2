import 'dart:convert';
import 'dart:io';

import 'package:KuyMinum/model/data_harian_model.dart';
import 'package:KuyMinum/service/Service.dart';
import 'package:dio/dio.dart';

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

  Future getDataToday(var data) async {
    try {
      var url = '/hariini';

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