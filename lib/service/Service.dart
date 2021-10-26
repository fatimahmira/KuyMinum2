import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:KuyMinum/locator.dart';
import 'package:KuyMinum/service/ApiInterceptors.dart';
import 'package:dio/dio.dart';
import 'ErrorDioHandler.dart';

class Service {
  Dio dio = locator<ApiInterceptors>().dio;
  String baseUrl = 'https://kuyminum.favianriyanto.my.id/api';

  Future get(String url) async {
    try {
      url = baseUrl + url;
      if (await locator<ApiInterceptors>().checkConnection()) {
        final response =
        dio.get(url, options: Options(headers: {"token": true}));
        return response;
      } else {
        print('no');
        throw TimeoutException('no_internet');
      }
    } on TimeoutException catch (e) {
      throw SocketException('no_internet');
    } catch (error) {
      log(error.toString(), name: 'error');
      errorDioHandler(error);
    }
  }

  Future postLogin2(String url, var data) async {
    try{
      url = baseUrl + url;
      print(url);
      if (await locator<ApiInterceptors>().checkConnection()) {
        print(data);
        final Response response = await dio.post(url,
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            }),
            data: data);
        print("post login 2");
        return response;
      } else {
        print('no');
        throw SocketException('no_internet');
      }
    }on TimeoutException catch (e) {
      throw SocketException('no_internet');
    } catch (error) {
      errorDioHandler(error);
    }
  }
  //
  // Future postLogin(String url, var data) async {
  //   try{
  //     url = baseUrl + url;
  //     print(url);
  //     if (await locator<ApiInterceptors>().checkConnection()) {
  //       print(data);
  //       final Response response = await dio.post(url,
  //           options: Options(headers: {
  //             'Content-Type': 'application/json',
  //             'Accept': 'application/json',
  //           }),
  //           data: data);
  //       return response;
  //     } else {
  //       print('no');
  //       throw SocketException('no_internet');
  //     }
  //   }on TimeoutException catch (e) {
  //     throw SocketException('no_internet');
  //   } catch (error) {
  //     errorDioHandler(error);
  //   }
  // }


  Future post(String url, var data) async {
    try{
      url = baseUrl + url;
      print(url);
      if (await locator<ApiInterceptors>().checkConnection()) {
        final response = await dio.post(url,
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              "token": true
            }),
            data: data);
        return response;
      } else {
        print('no');
        throw SocketException('no_internet');
      }
    } on TimeoutException catch (e) {
      throw SocketException('no_internet');
    } catch (error) {
      errorDioHandler(error);
    }
  }

  Future delete(String url, var data) async {
    try{
      url = baseUrl + url;
      print(url);
      if (await locator<ApiInterceptors>().checkConnection()) {
        final response = await dio.delete(url,
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'token': true
            }),
            data: data);

        print("berhasil delete");
        print(response);
        return response;
      } else {
        print('no');
        throw SocketException('no_internet');
      }
    } on TimeoutException catch (e) {
      throw SocketException('no_internet');
    } catch (error) {
      errorDioHandler(error);
    }
  }
}