import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:mhd_ghaith_top_stories/core/error_handler/error_handler.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';
import 'package:mhd_ghaith_top_stories/core/network/network_info.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/data_sources/top_stories_remote_data_source.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/params/top_stories_params.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/entities/top_stories_entity.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/domain/repositories/itop_stories_repository.dart';

class TopStoriesRepository extends ITopStoriesRepository {
  final ITopStoriesRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  TopStoriesRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, TopStoriesEntity>> getTopStories(
      TopStoriesParams topStoriesParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.getTopStories(topStoriesParams);
        if (response.status == ResponseMessage.success) {
          return Right(response.toEntity());
        } else {
          Logger().e(
              "Error while getting top stories: ${ResponseMessage.unKnown.toString()}");
          return Left(DataSource.unKnown.getFailure());
        }
      } catch (e) {
        Logger().e("Error while getting top stories: ${e.toString()}");
        return Left(ErrorHandler.handle(e).errorEntity);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
