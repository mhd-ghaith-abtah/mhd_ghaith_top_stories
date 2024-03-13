import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mhd_ghaith_top_stories/app/storage/app_storage.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/http_client.dart';
import 'package:mhd_ghaith_top_stories/core/network/dio_factory.dart';
import 'package:mhd_ghaith_top_stories/core/network/network_info.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  ///register flutter Secure Storage as lazy singleton
  if (!GetIt.I.isRegistered<FlutterSecureStorage>()) {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    instance.registerLazySingleton<FlutterSecureStorage>(
      () => flutterSecureStorage,
    );
  }

  ///register app storage as lazy singleton
  if (!GetIt.I.isRegistered<AppStorage>()) {
    instance.registerLazySingleton<AppStorage>(
        () => AppStorage(instance<FlutterSecureStorage>()));
  }

  ///register network info as lazy singleton
  if (!GetIt.I.isRegistered<NetworkInfoImpl>() &&
      !GetIt.I.isRegistered<NetworkInfo>()) {
    instance.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(InternetConnectionChecker()));
  }

  ///register dio factory as lazy singleton
  if (!GetIt.I.isRegistered<DioFactory>()) {
    instance.registerLazySingleton<DioFactory>(() => DioFactory());
  }

  ///register http client as lazy singleton
  if (!GetIt.I.isRegistered<HttpClient>()) {
    instance.registerLazySingleton<HttpClient>(() => HttpClient(
          instance<DioFactory>().getDio(),
        ));
  }
}
