import 'package:dartz/dartz.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/use_case/use_case.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/params/top_stories_params.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/entities/top_stories_entity.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/repositories/itop_stories_repository.dart';

class GetTopStoriesUseCase extends UseCase<TopStoriesEntity, TopStoriesParams> {
  ITopStoriesRepository repository;

  GetTopStoriesUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, TopStoriesEntity>> call(
          TopStoriesParams params) async =>
      await repository.getTopStories(params);
}
