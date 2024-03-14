import 'package:dartz/dartz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:mhd_ghaith_top_stories/app/dependency_injection/dependency_injection.dart';
import 'package:mhd_ghaith_top_stories/core/error_handler/error_handler.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/models/response/base_response_model.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';
import 'package:mhd_ghaith_top_stories/core/network/network_info.dart';

class Utils {
  static Future<void> showToast(String message) async =>
      await Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
      );
}

typedef FutureFunction<T> = Future<T> Function();

Future<Either<ErrorEntity, T>> sendRequest<T extends BaseResponseModel>(
  FutureFunction<T> call,
  String errorMessageToConsole,
) async {
  if (await (instance<NetworkInfo>()).isConnected) {
    try {
      final response = await call();
      if (response.status == ResponseMessage.success) {
        return Right(response);
      } else {
        Logger()
            .e("$errorMessageToConsole ${ResponseMessage.unKnown.toString()}");
        return Left(DataSource.unKnown.getFailure());
      }
    } catch (e) {
      Logger().e("$errorMessageToConsole ${e.toString()}");
      return Left(ErrorHandler.handle(e).errorEntity);
    }
  } else {
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
