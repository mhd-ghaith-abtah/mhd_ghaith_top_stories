import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mhd_ghaith_top_stories/core/utils/enums.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/data_sources/top_stories_remote_data_source.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/params/top_stories_params.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/json_reader.dart';
import '../../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late TopStoriesRemoteDataSource topStoriesRemoteDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    topStoriesRemoteDataSource = TopStoriesRemoteDataSource(mockHttpClient);
  });

  TopStoriesParamsBody topStoriesParamsBody =
      TopStoriesParamsBody(apiKey: 'apiKey', section: Section.home);

  TopStoriesParams topStoriesParams =
      TopStoriesParams(body: topStoriesParamsBody);

  final Map<String, dynamic> jsonMap = json.decode(
    readJson('helpers/dummy_data/dummy_top_stories_api_response.json'),
  );

  test('should return TopStoriesResponse when the response is valid json',
      () async {
    //arrange
    when(mockHttpClient.get(topStoriesParams)).thenAnswer((_) async => jsonMap);

    //act
    final result =
        await topStoriesRemoteDataSource.getTopStories(topStoriesParams);

    //assert
    expect(result, isA<TopStoriesResponse>());
  });
}
