import 'package:dartz/dartz.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/repository/irepository.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/params/top_stories_params.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';

abstract class ITopStoriesRepository extends IRepository {
  Future<Either<ErrorEntity, TopStoriesResponse>> getTopStories(
      TopStoriesParams topStoriesParams);
}
