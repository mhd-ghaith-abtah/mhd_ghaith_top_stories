import 'package:dartz/dartz.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/models/response/base_response_model.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';

abstract class UseCase<Response extends BaseResponseModel,
    Params extends ParamsModel> {
  Future<Either<ErrorEntity, Response>> call(Params params);
}
