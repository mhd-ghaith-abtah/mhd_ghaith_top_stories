part of 'top_stories_bloc.dart';

@immutable
abstract class TopStoriesState {
  final TopStoriesBlocStateType stateType;

  TopStoriesState({required this.stateType});
}

class TopStoriesInitial extends TopStoriesState {
  TopStoriesInitial({required super.stateType});
}

class TopStoriesLoading extends TopStoriesState {
  TopStoriesLoading({required super.stateType});
}

class TopStoriesLoaded extends TopStoriesState {
  TopStoriesLoaded({required super.stateType});
}

class TopStoriesError extends TopStoriesState {
  final String errorMessage;

  TopStoriesError({required super.stateType, required this.errorMessage});
}

enum TopStoriesBlocStateType {
  init,
  search,
  getStories,
  changeView,
  showHideFilters,
  noInternet
}
