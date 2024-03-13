import 'package:dio/dio.dart';
import 'package:mhd_ghaith_top_stories/app/app_configurations/app_configurations.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:mhd_ghaith_top_stories/core/utils/constants.dart';

class HttpClient {
  final Dio _dio;
  String? baseUrl;

  HttpClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= AppConfigurations.baseUrl;
  }

  Future<Map<String, dynamic>> get(ParamsModel model) async {
    String url = (model.baseUrl ?? baseUrl ?? _dio.options.baseUrl) +
        (model.url ?? Constants.empty);
    Response response;
    response = await _dio.get(
      url,
      options: Options(
        headers: _dio.options.headers,
        responseType: _dio.options.responseType,
        receiveTimeout: _dio.options.receiveTimeout,
        sendTimeout: _dio.options.sendTimeout,
      ),
      queryParameters: model.urlParams,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post(ParamsModel model) async {
    String url = (model.baseUrl ?? baseUrl ?? _dio.options.baseUrl) +
        (model.url ?? Constants.empty);
    Response response;
    response = await _dio.post(
      url,
      data: model.body?.toJson(),
      options: Options(
        headers: _dio.options.headers,
        responseType: _dio.options.responseType,
        receiveTimeout: _dio.options.receiveTimeout,
        sendTimeout: _dio.options.sendTimeout,
      ),
      queryParameters: model.urlParams,
    );
    return response.data;
  }
}
