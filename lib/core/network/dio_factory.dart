import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mhd_ghaith_top_stories/app/app_configurations/app_configurations.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/values_manager.dart';
import 'package:mhd_ghaith_top_stories/core/utils/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  Dio getDio() {
    Dio dio = Dio();

    Map<String, String?> headers = {
      Constants.contentType: Constants.applicationJson,
      Constants.accept: Constants.applicationJson,
    };

    dio.options = BaseOptions(
      baseUrl: AppConfigurations.baseUrl,
      headers: headers,
      responseType: ResponseType.json,
      receiveTimeout: AppDurations.timeout,
      sendTimeout: AppDurations.timeout,
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
