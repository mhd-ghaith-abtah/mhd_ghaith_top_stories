part of 'top_stories_bloc.dart';

@immutable
abstract class TopStoriesEvent {}

class GetTopStories extends TopStoriesEvent {
  final Section section;

  GetTopStories({required this.section});
}

class ChangeViewType extends TopStoriesEvent {}

class SearchInStories extends TopStoriesEvent {
  final String searchText;

  SearchInStories({required this.searchText});
}
