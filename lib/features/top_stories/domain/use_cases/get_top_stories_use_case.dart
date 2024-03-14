import 'package:dartz/dartz.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/use_case/use_case.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/params/top_stories_params.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/repositories/top_stories_repository.dart';

class GetTopStoriesUseCase
    extends UseCase<TopStoriesResponse, TopStoriesParams> {
  TopStoriesRepository repository;

  GetTopStoriesUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, TopStoriesResponse>> call(
          TopStoriesParams params) async =>
      repository.getTopStories(params);
}
