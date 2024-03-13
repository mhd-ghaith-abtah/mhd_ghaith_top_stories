import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/strings_manager.dart';
import 'package:mhd_ghaith_top_stories/core/features/domain/entities/error_entity/error_entity.dart';

//ignore: must_be_immutable
class ErrorHandler extends Equatable implements Exception {
  late ErrorEntity errorEntity;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      errorEntity = _handleError(error);
    } else {
      errorEntity = DataSource.unKnown.getFailure();
    }
  }

  ErrorEntity _handleError(DioException error) {
    if (error.response?.data != null) {
      return ErrorEntity.fromJson(error.response?.data);
    } else {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ErrorEntity(
            fault: FaultModel(
              faultString: ResponseMessage.connectionTimeout,
              faultDetails: FaultDetailsModel(
                errorCode: ResponseCode.connectionTimeout.toString(),
              ),
            ),
          );
        case DioExceptionType.sendTimeout:
          return ErrorEntity(
            fault: FaultModel(
              faultString: ResponseMessage.sendTimeout,
              faultDetails: FaultDetailsModel(
                errorCode: ResponseCode.sendTimeout.toString(),
              ),
            ),
          );
        case DioExceptionType.receiveTimeout:
          return ErrorEntity(
            fault: FaultModel(
              faultString: ResponseMessage.receiveTimeout,
              faultDetails: FaultDetailsModel(
                errorCode: ResponseCode.receiveTimeout.toString(),
              ),
            ),
          );
        case DioExceptionType.badResponse:
          return ErrorEntity(
            fault: FaultModel(
              faultString: ResponseMessage.badRequest,
              faultDetails: FaultDetailsModel(
                errorCode: ResponseCode.badRequest.toString(),
              ),
            ),
          );
        case DioExceptionType.cancel:
          return ErrorEntity(
            fault: FaultModel(
              faultString: ResponseMessage.cancel,
              faultDetails: FaultDetailsModel(
                errorCode: ResponseCode.cancel.toString(),
              ),
            ),
          );
        case DioExceptionType.unknown:
          return ErrorEntity(
            fault: FaultModel(
              faultString: ResponseMessage.unKnown,
              faultDetails: FaultDetailsModel(
                errorCode: ResponseCode.unKnown.toString(),
              ),
            ),
          );
        case DioExceptionType.badCertificate:
          return ErrorEntity(
            fault: FaultModel(
              faultString: ResponseMessage.unKnown,
              faultDetails: FaultDetailsModel(
                errorCode: ResponseCode.badCertificate.toString(),
              ),
            ),
          );
        case DioExceptionType.connectionError:
          return ErrorEntity(
            fault: FaultModel(
              faultString: ResponseMessage.unKnown,
              faultDetails: FaultDetailsModel(
                errorCode: ResponseCode.connectionError.toString(),
              ),
            ),
          );
      }
    }
  }

  @override
  List<Object?> get props => [errorEntity];
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorized,
  notFound,
  internalServerError,
  connectionTimeout,
  receiveTimeout,
  sendTimeout,
  cancel,
  cacheError,
  noInternetConnection,
  unKnown,
}

extension DataSourceExtension on DataSource {
  ErrorEntity getFailure() {
    switch (this) {
      case DataSource.success:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.success,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.success.toString(),
            ),
          ),
        );
      case DataSource.noContent:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.noContent,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.noContent.toString(),
            ),
          ),
        );
      case DataSource.badRequest:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.badRequest,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.badRequest.toString(),
            ),
          ),
        );
      case DataSource.forbidden:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.forbidden,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.forbidden.toString(),
            ),
          ),
        );
      case DataSource.unAuthorized:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.unAuthorized,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.unAuthorized.toString(),
            ),
          ),
        );
      case DataSource.notFound:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.notFound,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.notFound.toString(),
            ),
          ),
        );
      case DataSource.internalServerError:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.internalServerError,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.internalServerError.toString(),
            ),
          ),
        );
      case DataSource.connectionTimeout:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.connectionTimeout,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.connectionTimeout.toString(),
            ),
          ),
        );
      case DataSource.receiveTimeout:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.receiveTimeout,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.receiveTimeout.toString(),
            ),
          ),
        );
      case DataSource.sendTimeout:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.sendTimeout,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.sendTimeout.toString(),
            ),
          ),
        );
      case DataSource.cancel:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.cancel,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.cancel.toString(),
            ),
          ),
        );
      case DataSource.cacheError:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.cacheError,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.cacheError.toString(),
            ),
          ),
        );
      case DataSource.noInternetConnection:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.noInternetConnection,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.noInternetConnection.toString(),
            ),
          ),
        );
      case DataSource.unKnown:
        return ErrorEntity(
          fault: FaultModel(
            faultString: ResponseMessage.unKnown,
            faultDetails: FaultDetailsModel(
              errorCode: ResponseCode.unKnown.toString(),
            ),
          ),
        );
    }
  }
}

class ResponseCode {
  static const success = 200;
  static const noContent = 201;
  static const badRequest = 400;
  static const unAuthorized = 401;
  static const forbidden = 403;
  static const notFound = 404;
  static const badCertificate = 495;
  static const internalServerError = 500;
  static const connectionError = 502;
  static const connectionTimeout = 599;
  static const receiveTimeout = 408;
  static const sendTimeout = 408;
  static const cancel = -1;
  static const cacheError = -2;
  static const noInternetConnection = -3;
  static const unKnown = -4;
}

class ResponseMessage {
  static String success = AppStrings.success;
  static String noContent = AppStrings.noContent;
  static String badRequest = AppStrings.badRequest;
  static String unAuthorized = AppStrings.unAuthorized;
  static String forbidden = AppStrings.forbidden;
  static String notFound = AppStrings.notFound;
  static String internalServerError = AppStrings.internalServerError;
  static String connectionTimeout = AppStrings.connectionTimeout;
  static String cancel = AppStrings.cancel;
  static String receiveTimeout = AppStrings.receiveTimeout;
  static String sendTimeout = AppStrings.sendTimeout;
  static String cacheError = AppStrings.cacheError;
  static String noInternetConnection = AppStrings.noInternetConnection;
  static String unKnown = AppStrings.unKnown;
}
