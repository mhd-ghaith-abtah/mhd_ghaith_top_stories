import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  final SharedPreferences _storage;

  AppStorage(this._storage);

  final _apiKey = "API_KEY";
  final _firstTimeAppOpenedKey = "FIRST_APP_OPEN_KEY";
  final _cachedStoriesKey = "CACHED_STORIES_KEY";

  Future<void> setAPIKey({required String apiKeyValue}) async => await _storage
      .setString(_apiKey, apiKeyValue)
      .then((_) async => await _storage.setBool(_firstTimeAppOpenedKey, false));

  String? getAPIKey() => _storage.getString(_apiKey);

  Future<bool> removeAPIKey() async => await _storage.remove(_apiKey);

  bool getFirstAppOpen() => _storage.getBool(_firstTimeAppOpenedKey) ?? true;

  Future<void> setCachedStories({required String stories}) async =>
      await _storage.setString(_cachedStoriesKey, stories);

  String? getCachedStories() => _storage.getString(_cachedStoriesKey);

  Future<bool> removeCachedStories() async =>
      await _storage.remove(_cachedStoriesKey);
}
