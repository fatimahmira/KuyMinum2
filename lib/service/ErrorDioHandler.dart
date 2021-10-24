import 'dart:io';

import 'package:dio/dio.dart';

void errorDioHandler(DioError error){
  if (error is DioError) {
    if (error.error.toString().contains('SocketException')) {
      throw SocketException('no_internet');
    }
    if (error.type == DioErrorType.CONNECT_TIMEOUT ||
        error.type == DioErrorType.SEND_TIMEOUT) {
      throw SocketException('no_internet');
    }
  }
}