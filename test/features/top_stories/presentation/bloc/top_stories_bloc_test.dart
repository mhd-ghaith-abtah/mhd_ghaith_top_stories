import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mhd_ghaith_top_stories/core/error_handler/error_handler.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';
import 'package:mhd_ghaith_top_stories/core/utils/enums.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/params/top_stories_params.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/entities/top_stories_entity.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/presentation/bloc/top_stories_bloc/top_stories_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockGetTopStoriesUseCase mockGetTopStoriesUseCase;
  late MockAppStorage mockAppStorage;
  late TopStoriesBloc topStoriesBloc;

  setUp(() {
    mockGetTopStoriesUseCase = MockGetTopStoriesUseCase();
    mockAppStorage = MockAppStorage();
    topStoriesBloc = TopStoriesBloc(mockAppStorage, mockGetTopStoriesUseCase);
  });

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

  TopStoriesEntity topStoriesEntity = TopStoriesEntity(result: [topStoryModel]);

  TopStoriesParamsBody topStoriesParamsBody =
      TopStoriesParamsBody(apiKey: 'apiKey', section: Section.home);

  TopStoriesParams topStoriesParams =
      TopStoriesParams(body: topStoriesParamsBody);

  test('initial state should TopStoriesInitial', () {
    expect(topStoriesBloc.state,
        TopStoriesInitial(stateType: TopStoriesBlocStateType.init));
  });

  blocTest<TopStoriesBloc, TopStoriesState>(
    """should emit [
    TopStoriesLoading(stateType: TopStoriesBlocStateType.getStories),
    TopStoriesLoaded(stateType: TopStoriesBlocStateType.getStories),
    ] when data is gotten successfully""",
    build: () {
      when(mockAppStorage.getCachedStories()).thenAnswer((_) => null);
      when(mockAppStorage.getAPIKey()).thenAnswer((_) => "apiKey");
      when(mockGetTopStoriesUseCase.call(topStoriesParams))
          .thenAnswer((_) async => Right(topStoriesEntity));
      return topStoriesBloc;
    },
    act: (bloc) => bloc.add(GetTopStories(section: Section.home)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopStoriesLoading(stateType: TopStoriesBlocStateType.getStories),
      TopStoriesLoaded(stateType: TopStoriesBlocStateType.getStories)
    ],
  );

  blocTest<TopStoriesBloc, TopStoriesState>(
    """should emit [
    TopStoriesLoading(stateType: TopStoriesBlocStateType.getStories),
     TopStoriesError(stateType: TopStoriesBlocStateType.noInternet,
     errorMessage: noInternetError.fault?.faultString ?? "",
     ),
     ]
     when get data is unsuccessful""",
    build: () {
      when(mockAppStorage.getCachedStories()).thenAnswer((_) => null);
      when(mockAppStorage.getAPIKey()).thenAnswer((_) => "apiKey");
      when(mockGetTopStoriesUseCase.call(topStoriesParams))
          .thenAnswer((_) async => Left(noInternetError));
      return topStoriesBloc;
    },
    act: (bloc) => bloc.add(GetTopStories(section: Section.home)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopStoriesLoading(stateType: TopStoriesBlocStateType.getStories),
      TopStoriesError(
        stateType: TopStoriesBlocStateType.noInternet,
        errorMessage: noInternetError.fault?.faultString ?? "",
      ),
    ],
  );

  blocTest<TopStoriesBloc, TopStoriesState>(
    """should emit [
    TopStoriesLoaded(stateType: TopStoriesBlocStateType.getStories),
    ] when search text is empty""",
    build: () {
      return topStoriesBloc;
    },
    act: (bloc) => bloc.add(SearchInStories(searchText: "")),
    wait: const Duration(milliseconds: 500),
    expect: () =>
        [TopStoriesLoaded(stateType: TopStoriesBlocStateType.getStories)],
  );
}
