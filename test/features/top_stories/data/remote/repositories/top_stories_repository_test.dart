import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mhd_ghaith_top_stories/core/error_handler/error_handler.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';
import 'package:mhd_ghaith_top_stories/core/utils/enums.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/params/top_stories_params.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/repositories/top_stories_repository.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/entities/top_stories_entity.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockITopStoriesRemoteDataSource mockITopStoriesRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late TopStoriesRepository topStoriesRepository;

  setUp(() {
    mockITopStoriesRemoteDataSource = MockITopStoriesRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    topStoriesRepository =
        TopStoriesRepository(mockITopStoriesRemoteDataSource, mockNetworkInfo);
  });

  ErrorEntity error = ErrorEntity(
      fault: FaultModel(
    faultDetails:
        FaultDetailsModel(errorCode: ResponseCode.connectionTimeout.toString()),
    faultString: ResponseMessage.connectionTimeout,
  ));

  ErrorEntity noInternetError = ErrorEntity(
      fault: FaultModel(
    faultDetails: FaultDetailsModel(
        errorCode: ResponseCode.noInternetConnection.toString()),
    faultString: ResponseMessage.noInternetConnection,
  ));

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

  TopStoriesEntity topStoriesEntity = TopStoriesEntity(result: [topStoryModel]);

  TopStoriesParamsBody topStoriesParamsBody =
      TopStoriesParamsBody(apiKey: 'apiKey', section: Section.home);

  TopStoriesParams topStoriesParams =
      TopStoriesParams(body: topStoriesParamsBody);

  group('get top stories', () {
    test(
      'should return current top stories when a call to data source is successful',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockITopStoriesRemoteDataSource.getTopStories(topStoriesParams))
            .thenAnswer((_) async => topStoriesResponse);

        // act
        final result =
            await topStoriesRepository.getTopStories(topStoriesParams);

        // assert
        expect(result, equals(Right(topStoriesEntity)));
      },
    );

    test(
      'should return error entity when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockITopStoriesRemoteDataSource.getTopStories(topStoriesParams))
            .thenThrow(DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionTimeout,
        ));

        // act
        final result =
            await topStoriesRepository.getTopStories(topStoriesParams);

        // assert
        expect(result, equals(Left(error)));
      },
    );

    test(
      'should return error entity when the device has no internet',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // act
        final result =
            await topStoriesRepository.getTopStories(topStoriesParams);

        // assert
        expect(result, equals(Left(noInternetError)));
      },
    );
  });
}
