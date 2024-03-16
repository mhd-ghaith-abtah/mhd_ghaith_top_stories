import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mhd_ghaith_top_stories/app/storage/app_storage.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/http_client.dart';
import 'package:mhd_ghaith_top_stories/core/network/dio_factory.dart';
import 'package:mhd_ghaith_top_stories/core/network/network_info.dart';
import 'package:mhd_ghaith_top_stories/features/splash/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/data_sources/top_stories_remote_data_source.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/repositories/top_stories_repository.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/use_cases/get_top_stories_use_case.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/presentation/bloc/top_stories_bloc/top_stories_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  ///register flutter Secure Storage as lazy singleton
  if (!GetIt.I.isRegistered<SharedPreferences>()) {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }

  ///register app storage as lazy singleton
  if (!GetIt.I.isRegistered<AppStorage>()) {
    instance.registerLazySingleton<AppStorage>(
        () => AppStorage(instance<SharedPreferences>()));
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
  if (!GetIt.I.isRegistered<TopStoriesHttpClient>()) {
    instance.registerLazySingleton<TopStoriesHttpClient>(() => TopStoriesHttpClient(
          instance<DioFactory>().getDio(),
        ));
  }
}

void initSplashModule() {
  ///register splash cubit as factory
  if (!GetIt.I.isRegistered<SplashCubit>()) {
    instance.registerFactory<SplashCubit>(
        () => SplashCubit(instance<AppStorage>()));
  }
}

void initTopStoriesModule() {
  ///register top stories remote data source as lazy singleton
  if (!GetIt.I.isRegistered<TopStoriesRemoteDataSource>()) {
    instance.registerLazySingleton<TopStoriesRemoteDataSource>(
        () => TopStoriesRemoteDataSource(instance<TopStoriesHttpClient>()));
  }

  ///register top stories repository as lazy singleton
  if (!GetIt.I.isRegistered<TopStoriesRepository>()) {
    instance
        .registerLazySingleton<TopStoriesRepository>(() => TopStoriesRepository(
              instance<TopStoriesRemoteDataSource>(),
              instance<NetworkInfo>(),
            ));
  }

  ///register get top stories use case as lazy singleton
  if (!GetIt.I.isRegistered<GetTopStoriesUseCase>()) {
    instance.registerLazySingleton<GetTopStoriesUseCase>(
        () => GetTopStoriesUseCase(instance<TopStoriesRepository>()));
  }

  ///register top stories bloc as factory
  if (!GetIt.I.isRegistered<TopStoriesBloc>()) {
    instance.registerFactory<TopStoriesBloc>(() => TopStoriesBloc(
          instance<AppStorage>(),
          instance<GetTopStoriesUseCase>(),
        ));
  }
}
