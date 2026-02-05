import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';

class FavoritesService {
  SharedPreferences? _prefs;

  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<List<String>> getFavorites() async {
    final prefs = await _preferences;
    final json = prefs.getString(AppConstants.favoritesKey);
    if (json == null) return [];
    try {
      return (jsonDecode(json) as List).cast<String>();
    } catch (e) {
      // If decoding fails, return empty list
      return [];
    }
  }

  Future<void> saveFavorites(List<String> ids) async {
    final prefs = await _preferences;
    await prefs.setString(AppConstants.favoritesKey, jsonEncode(ids));
    await prefs.setInt(
      AppConstants.lastSyncKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<bool> isFavorite(String id) async {
    final favorites = await getFavorites();
    return favorites.contains(id);
  }

  Future<void> addFavorite(String id) async {
    final favorites = await getFavorites();
    if (!favorites.contains(id)) {
      favorites.add(id);
      await saveFavorites(favorites);
    }
  }

  Future<void> removeFavorite(String id) async {
    final favorites = await getFavorites();
    favorites.remove(id);
    await saveFavorites(favorites);
  }

  Future<void> toggleFavorite(String id) async {
    final favorites = await getFavorites();
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    await saveFavorites(favorites);
  }

  Future<void> clearAll() async {
    final prefs = await _preferences;
    await prefs.remove(AppConstants.favoritesKey);
    await prefs.remove(AppConstants.lastSyncKey);
  }

  Future<int> getCount() async {
    final favorites = await getFavorites();
    return favorites.length;
  }

  Future<DateTime?> getLastSyncTime() async {
    final prefs = await _preferences;
    final timestamp = prefs.getInt(AppConstants.lastSyncKey);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}
