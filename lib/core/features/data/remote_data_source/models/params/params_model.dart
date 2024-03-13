import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mhd_ghaith_top_stories/core/utils/enums.dart';

@immutable
abstract class ParamsModel<BodyModelType extends BaseBodyModel>
    extends Equatable {
  final BodyModelType? body;

  /// set this to override base url
  final String? baseUrl;

  /// add additional headers to request here
  Map<String, String>? get additionalHeaders;

  /// type of request : [RequestType.POST] or [RequestType.GET]
  RequestType get requestType;

  /// [url] to api endpoint (without base url)
  /// not url is without page number or length
  /// you should fill base_url property in base provider
  String? get url;

  /// query parameters to be included in url
  Map<String, dynamic>? get urlParams;

  const ParamsModel({this.body, this.baseUrl});
}

abstract class BaseBodyModel {
  Map<String, dynamic> toJson();
}
