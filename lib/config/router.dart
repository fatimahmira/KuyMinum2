
import 'package:KuyMinum/config/string_router.dart';
import 'package:KuyMinum/view/data_diri.dart';
import 'package:KuyMinum/view/data_harian.dart';
import 'package:KuyMinum/view/halaman_minum.dart';
import 'package:KuyMinum/view/home.dart';
import 'package:KuyMinum/view/pengaturan.dart';
import 'package:flutter/material.dart';

class AppRouter {
Route onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case StringRouter.home:
      return MaterialPageRoute(builder: (_) => Home());
      break;
    case StringRouter.data_diri:
      return MaterialPageRoute(builder: (_) => DataDiri());
      break;
    case StringRouter.halaman_minum:
      return MaterialPageRoute(builder: (_) => HalamanMinum());
      break;
    case StringRouter.pengaturan:
      return MaterialPageRoute(builder: (_) => Pengaturan());
      break;
    case StringRouter.data_minum:
      return MaterialPageRoute(builder: (_) => DataHarian());
      break;
  }
}
}