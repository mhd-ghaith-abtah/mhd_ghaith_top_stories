import 'package:dartz/dartz.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/http_client.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';
import 'package:mhd_ghaith_top_stories/core/utils/extensions.dart';
import 'package:mhd_ghaith_top_stories/core/utils/utils.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/params/top_stories_params.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/repositories/itop_stories_repository.dart';

class TopStoriesRepository extends ITopStoriesRepository {
  final HttpClient _httpClient;

  TopStoriesRepository(this._httpClient);

  @override
  Future<Either<ErrorEntity, TopStoriesResponse>> getTopStories(
          TopStoriesParams topStoriesParams) async =>
      await sendRequest(
          () async => await topStoriesParams.requestType
              .getHTTPRequestType(
                _httpClient,
                topStoriesParams,
              )
              .then((res) => Future.value(TopStoriesResponse.fromJson(res))),
          "Error while getting top stories from server: ");
}
