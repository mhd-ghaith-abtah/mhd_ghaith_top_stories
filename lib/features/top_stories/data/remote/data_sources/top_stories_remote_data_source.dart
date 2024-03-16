import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/http_client.dart';
import 'package:mhd_ghaith_top_stories/core/utils/extensions.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/params/top_stories_params.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';

abstract class ITopStoriesRemoteDataSource {
  final TopStoriesHttpClient _httpClient;

  ITopStoriesRemoteDataSource(this._httpClient);

  Future<TopStoriesResponse> getTopStories(TopStoriesParams topStoriesParams);
}

class TopStoriesRemoteDataSource extends ITopStoriesRemoteDataSource {
  TopStoriesRemoteDataSource(
    super._httpClient,
  );

  @override
  Future<TopStoriesResponse> getTopStories(
      TopStoriesParams topStoriesParams) async {
    var res = await topStoriesParams.requestType
        .getHTTPRequestType(_httpClient, topStoriesParams);
    return Future.value(TopStoriesResponse.fromJson(res));
  }
}
