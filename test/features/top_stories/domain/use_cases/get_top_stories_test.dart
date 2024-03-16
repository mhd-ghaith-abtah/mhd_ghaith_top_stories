import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mhd_ghaith_top_stories/core/utils/enums.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/params/top_stories_params.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/entities/top_stories_entity.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/use_cases/get_top_stories_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockITopStoriesRepository mockTopStoriesRepository;
  late GetTopStoriesUseCase getTopStoriesUseCase;

  setUp(() {
    mockTopStoriesRepository = MockITopStoriesRepository();
    getTopStoriesUseCase = GetTopStoriesUseCase(mockTopStoriesRepository);
  });

  TopStoriesParamsBody topStoriesParamsBody =
      TopStoriesParamsBody(apiKey: 'apiKey', section: Section.home);

  TopStoriesParams topStoriesParams =
      TopStoriesParams(body: topStoriesParamsBody);

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
  TopStoriesEntity topStoriesEntity = TopStoriesEntity(result: [topStoryModel]);

  test(
    "Get all top stories from the repository",
    () async {
      // arrange
      when(mockTopStoriesRepository.getTopStories(any))
          .thenAnswer((_) async => Right(topStoriesEntity));
      // act
      final result = await getTopStoriesUseCase.call(topStoriesParams);
      // assert
      expect(result, Right(topStoriesEntity));
      verify(mockTopStoriesRepository.getTopStories(topStoriesParams));
      verifyNoMoreInteractions(mockTopStoriesRepository);
    },
  );
}
