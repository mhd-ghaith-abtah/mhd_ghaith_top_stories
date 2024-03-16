import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/models/response/base_response_model.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';

import '../../../../../../helpers/json_reader.dart';

void main() {
  const multiMedia = MultiMedia(
    url: "url",
    height: 10,
    width: 10,
    type: "type",
    caption: "caption",
  );

  TopStoryModel topStoryModel = TopStoryModel(
    section: "section",
    subsection: "subsection",
    title: "title",
    abstract: "abstract",
    url: "url",
    byline: "byline",
    itemType: "itemType",
    updatedDate: DateTime.tryParse("2024-03-15T13:39:31-04:00"),
    createdDate: DateTime.tryParse("2024-03-15T13:39:31-04:00"),
    publishedDate: DateTime.tryParse("2024-03-15T13:39:31-04:00"),
    multimedia: const [multiMedia],
  );

  TopStoriesResponse topStoriesResponse = TopStoriesResponse(
    "OK",
    "copyright",
    "section",
    "last_updated",
    1,
    result: [topStoryModel],
  );

  test("Should be a subclass of BaseResponseModel", () async {
    //assert
    expect(topStoriesResponse, isA<BaseResponseModel>());
  });

  test('should return a valid TopStoriesResponse from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_top_stories_api_response.json'),
    );

    //act
    final result = TopStoriesResponse.fromJson(jsonMap);

    //assert
    expect(result, equals(topStoriesResponse));
  });

  test(
    'should return a json map containing proper data',
        () async {

      // act
      final result = topStoriesResponse.toJson();

      // assert
      final Map<String, dynamic> expectedJsonMap = json.decode(
        readJson('helpers/dummy_data/dummy_top_stories_api_response_to_json.json'),
      );

      expect(result, equals(expectedJsonMap));

    },
  );
}
