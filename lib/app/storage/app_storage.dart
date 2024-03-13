import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStorage {
  final FlutterSecureStorage _storage;

  AppStorage(this._storage);

  final _apiKey = "API_KEY";
  final _firstTimeAppOpened = "FIRST_APP_OPEN_KEY";

  Future<void> setAPIKey({required String apiKeyValue}) async =>
      await _storage.write(key: _apiKey, value: apiKeyValue).then((_) async =>
          await _storage.write(key: _firstTimeAppOpened, value: "true"));

  Future<String?> getAPIKey() async => await _storage.read(key: _apiKey);

  Future<String?> getFirstAppOpen() async =>
      await _storage.read(key: _firstTimeAppOpened);
}
