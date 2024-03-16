part of 'top_stories_bloc.dart';

@immutable
abstract class TopStoriesState extends Equatable {
  final TopStoriesBlocStateType stateType;

  TopStoriesState({required this.stateType});
}

class TopStoriesInitial extends TopStoriesState {
  TopStoriesInitial({required super.stateType});

  @override
  List<Object?> get props => [stateType];
}

class TopStoriesLoading extends TopStoriesState {
  TopStoriesLoading({required super.stateType});

  @override
  List<Object?> get props => [stateType];
}

class TopStoriesLoaded extends TopStoriesState {
  TopStoriesLoaded({required super.stateType});

  @override
  List<Object?> get props => [stateType];
}

class TopStoriesError extends TopStoriesState {
  final String errorMessage;

  TopStoriesError({required super.stateType, required this.errorMessage});

  @override
  List<Object?> get props => [stateType, errorMessage];
}

enum TopStoriesBlocStateType {
  init,
  search,
  getStories,
  changeView,
  showHideFilters,
  noInternet
}
