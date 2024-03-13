import 'package:mhd_ghaith_top_stories/core/utils/constants.dart';

class AppConfigurations {
  static const String applicationName = "Top stories";
  static const String applicationVersion = "v1.0.0(1)";

  /// endpoints URLs
  static const String baseUrl = "https://api.nytimes.com/svc/topstories/v2";

  /// headers
  static const Map<String, String> baseHeaders = {
    Constants.accept: "*/*",
    Constants.contentType: Constants.applicationJson,
  };
}
