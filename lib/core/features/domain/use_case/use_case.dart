import 'package:dartz/dartz.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/entity.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';

abstract class UseCase<DataEntity extends Entity, Params extends ParamsModel> {
  Future<Either<ErrorEntity, DataEntity>> call(Params params);
}
