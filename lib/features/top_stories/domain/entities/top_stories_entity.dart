import 'package:mhd_ghaith_top_stories/core/features/domain/entities/entity.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';

class TopStoriesEntity extends Entity {
  final List<TopStoryModel>? result;

  TopStoriesEntity({required this.result});

  @override
  List<Object?> get props => [result];
}
