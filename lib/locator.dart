import 'package:KuyMinum/provider/data_hariaan_provider.dart';
import 'package:KuyMinum/provider/firestore_provider.dart';
import 'package:KuyMinum/provider/login_provider.dart';
import 'package:KuyMinum/provider/minum_provider.dart';
import 'package:KuyMinum/provider/notification_provider.dart';
import 'package:KuyMinum/provider/pengaturan_provider.dart';
import 'package:KuyMinum/provider/pilih_gelas_provider.dart';
import 'package:KuyMinum/service/ApiInterceptors.dart';
import 'package:KuyMinum/service/Service.dart';
import 'package:KuyMinum/service/data_harian_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiInterceptors());
  locator.registerLazySingleton(() => Service());
  locator.registerLazySingleton(() => DataHarianServices());

  locator.registerFactory(() => MinumProvider());
  locator.registerFactory(() => PilihGelasProvider());
  locator.registerFactory(() => LoginProvider());
  locator.registerFactory(() => PengaturanProvider());
  locator.registerFactory(() => NotificationProvider());
  locator.registerFactory(() => FirestoreProvider());
  locator.registerFactory(() => DataHarianProvider());

}
