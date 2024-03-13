import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/http_client.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:mhd_ghaith_top_stories/core/utils/enums.dart';

extension HTTPRequestType on RequestType {
  Future<Map<String, dynamic>> getHTTPRequestType(
    HttpClient httpClient,
    ParamsModel model,
  ) async {
    switch (this) {
      case RequestType.POST:
        return await httpClient.post(model);
      case RequestType.GET:
        return await httpClient.get(model);
    }
  }
}
