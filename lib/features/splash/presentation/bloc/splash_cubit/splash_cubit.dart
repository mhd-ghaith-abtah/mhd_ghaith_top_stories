import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/strings_manager.dart';
import 'package:mhd_ghaith_top_stories/app/storage/app_storage.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AppStorage _appStorage;

  SplashCubit(this._appStorage) : super(SplashInitial());

  final Logger _logger = Logger();

  Future<void> saveAPIKeyToStorage() async {
    emit(SavingAPIKey());
    try {
      final firstOpen = _appStorage.getFirstAppOpen();
      if (firstOpen) {
        await _appStorage.setAPIKey(
            apiKeyValue: "NXCJfe1fWqGDbvaOxvnqbSm4mhWFWVGp");
        emit(APIKeySavedSuccessfully());
      } else {
        emit(SplashLoaded());
      }
    } catch (e) {
      _logger.e(e.toString());
      emit(APIKeySavingError(errorMessage: AppStrings.unKnown));
    }
  }
}
