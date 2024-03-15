import 'dart:async';
import 'dart:convert';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/strings_manager.dart';
import 'package:mhd_ghaith_top_stories/app/storage/app_storage.dart';
import 'package:mhd_ghaith_top_stories/core/error_handler/error_handler.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';
import 'package:mhd_ghaith_top_stories/core/utils/constants.dart';
import 'package:mhd_ghaith_top_stories/core/utils/enums.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/local/models/cache_top_stories_model.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/params/top_stories_params.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/use_cases/get_top_stories_use_case.dart';

part 'top_stories_event.dart';

part 'top_stories_state.dart';

class TopStoriesBloc extends Bloc<TopStoriesEvent, TopStoriesState> {
  final AppStorage _appStorage;
  final GetTopStoriesUseCase _getTopStoriesUseCase;

  final List<TopStoryModel> _stories = List.empty(growable: true);
  final List<TopStoryModel> _storiesSearchResult = List.empty(growable: true);
  bool _isListView = true;
  bool _showFilters = false;
  Section _selectedSection = Section.home;

  List<TopStoryModel> get stories => _stories;

  List<TopStoryModel> get storiesSearchResult => _storiesSearchResult;

  bool get isListView => _isListView;

  bool get showFilters => _showFilters;

  Section get selectedSection => _selectedSection;

  TopStoriesBloc(
    this._appStorage,
    this._getTopStoriesUseCase,
  ) : super(TopStoriesInitial(
          stateType: TopStoriesBlocStateType.init,
        )) {
    on<GetTopStories>(_getTopStoriesEventImpl, transformer: restartable());

    on<ChangeViewType>(_changeViewTypeEventImpl);

    on<SearchInStories>(_searchInStoriesEventImpl, transformer: restartable());

    on<ShowHideFilter>(_showHideFilterEventImpl);
  }

  FutureOr<void> _getTopStoriesEventImpl(
    GetTopStories event,
    Emitter<TopStoriesState> emit,
  ) async {
    _selectedSection = event.section;
    _showFilters = false;
    emit(TopStoriesLoading(stateType: TopStoriesBlocStateType.getStories));
    ErrorEntity? errorEntity;
    TopStoriesResponse? topStoriesResponse;
    bool useCache = false;

    // get cached stories and parse
    final cachedStoriesString = _appStorage.getCachedStories();
    Map<String, dynamic> cachedStoriesMap =
        json.decode(cachedStoriesString ?? "{}");
    final currentSection = cachedStoriesMap[event.section.name];
    CacheTopStoriesModel? cachedModel;
    if (currentSection != null) {
      cachedModel = CacheTopStoriesModel.fromString(currentSection);
      // check if still valid
      if (DateTime.now().difference(cachedModel.cacheDate).inMinutes < 5) {
        topStoriesResponse = cachedModel.stories;
        useCache = true;
      }
    }

    if (useCache && !event.forceFromAPI) {
      _stories
        ..clear()
        ..addAll(topStoriesResponse?.result ?? []);
      emit(TopStoriesLoaded(stateType: TopStoriesBlocStateType.getStories));
    } else {
      var res = await _getTopStoriesUseCase.call(
        TopStoriesParams(
          body: TopStoriesParamsBody(
            apiKey: _appStorage.getAPIKey() ?? Constants.empty,
            section: event.section,
          ),
        ),
      );
      bool isError = res.fold((l) {
        errorEntity = l;
        return true;
      }, (r) {
        topStoriesResponse = r;
        return false;
      });

      if (isError) {
        _stories.clear();
        emit(TopStoriesError(
          stateType: errorEntity?.fault?.faultDetails?.errorCode ==
                  ResponseCode.noInternetConnection.toString()
              ? TopStoriesBlocStateType.noInternet
              : TopStoriesBlocStateType.getStories,
          errorMessage: errorEntity?.fault?.faultString ?? AppStrings.unKnown,
        ));
      } else {
        if (topStoriesResponse != null) {
          _stories.clear();
          for (var story in topStoriesResponse!.result!) {
            if (story.title?.isNotEmpty == true &&
                story.abstract?.isNotEmpty == true &&
                story.multimedia?.isNotEmpty == true) {
              _stories.add(story);
            }
          }
          // cache new stories
          CacheTopStoriesModel cacheTopStoriesModel = CacheTopStoriesModel(
            cacheDate: DateTime.now(),
            section: event.section.name,
            stories: topStoriesResponse!,
          );
          cachedStoriesMap.update(
            event.section.name,
            (value) => cacheTopStoriesModel.toString(),
            ifAbsent: () => cacheTopStoriesModel.toString(),
          );
          await _appStorage.setCachedStories(
              stories: json.encode(cachedStoriesMap));
        }
        emit(TopStoriesLoaded(stateType: TopStoriesBlocStateType.getStories));
      }
    }
  }

  FutureOr<void> _changeViewTypeEventImpl(
    ChangeViewType event,
    Emitter<TopStoriesState> emit,
  ) async {
    _isListView = !_isListView;
    final currentState = state;
    emit(TopStoriesLoaded(stateType: TopStoriesBlocStateType.changeView));
    emit(currentState);
  }

  FutureOr<void> _searchInStoriesEventImpl(
    SearchInStories event,
    Emitter<TopStoriesState> emit,
  ) async {
    _storiesSearchResult.clear();
    if (event.searchText.isNotEmpty) {
      emit(TopStoriesLoading(stateType: TopStoriesBlocStateType.search));
      await Future.delayed(const Duration(milliseconds: 75));
      for (var story in _stories) {
        String? authorSplitResult = story.byline?.replaceAll("By ", " ");
        authorSplitResult = authorSplitResult?.replaceAll(", ", " ");
        authorSplitResult = authorSplitResult?.replaceAll(" and ", " ");
        if (story.title
                    ?.toLowerCase()
                    .contains(event.searchText.toLowerCase()) ==
                true ||
            authorSplitResult
                    ?.toLowerCase()
                    .contains(event.searchText.toLowerCase()) ==
                true) {
          _storiesSearchResult.add(story);
        }
      }
      emit(TopStoriesLoaded(stateType: TopStoriesBlocStateType.search));
    } else {
      _storiesSearchResult.clear();
      emit(TopStoriesLoaded(stateType: TopStoriesBlocStateType.getStories));
    }
  }

  FutureOr<void> _showHideFilterEventImpl(
    ShowHideFilter event,
    Emitter<TopStoriesState> emit,
  ) async {
    _showFilters = event.isShow ?? !_showFilters;
    final currentState = state;
    emit(TopStoriesLoaded(stateType: TopStoriesBlocStateType.showHideFilters));
    emit(currentState);
  }
}
