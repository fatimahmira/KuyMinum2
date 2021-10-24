import 'dart:io';

import 'package:KuyMinum/service/Service.dart';
import 'package:dio/dio.dart';

class AuthService extends Service{

  Future<Response> postLogin(var data) async {
    try {
      var url = '/auth/login';
      print(url);

      var response = await postLogin2(url, data);

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

  Future<Response> postRegister(var data) async {
    try {
      var url = '/auth/register';

      var response = await postLogin2(url, data);

      if (response.statusCode == 201) {
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