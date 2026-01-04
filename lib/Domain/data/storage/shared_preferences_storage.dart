import 'dart:convert';
import 'package:flutter/widgets.dart';
import '../../model/Dream/dreams_model.dart';
import '../../model/User/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage {
  // Get instance
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // Save user data (convert object to JSON string)
  Future<void> saveUser(User user) async {
    try {
      final prefs = await _getPrefs();
      final userJson = jsonEncode(user.toMap());
      final success = await prefs.setString('user', userJson);
      debugPrint('User save result: $success, JSON: $userJson');

      // Verify it was saved
      final verify = prefs.getString('user');
      debugPrint('Verification read: $verify');
    } catch (e) {
      debugPrint('Error saving user: $e');
      rethrow;
    }
  }

  Future<User?> getUser() async {
    try {
      final prefs = await _getPrefs();

      // Debug: List all keys in SharedPreferences
      final allKeys = prefs.getKeys();
      debugPrint(' All SharedPreferences keys: $allKeys');

      final userJson = prefs.getString('user');
      debugPrint(' Reading key "user": $userJson');

      if (userJson != null) {
        return User.fromMap(jsonDecode(userJson));
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user: $e');
      return null;
    }
  }

  // Save user's dreams list
  Future<void> saveDreams(List<Dream> dreams) async {
    try {
      final prefs = await _getPrefs();
      final dreamsJson = dreams.map((dream) => dream.toMap()).toList();
      final jsonString = jsonEncode(dreamsJson);
      debugPrint('Saving ${dreams.length} dreams');
      debugPrint('JSON to save: $jsonString');
      await prefs.setString('userDreams', jsonString);
      debugPrint('Dreams saved successfully');
    } catch (e) {
      debugPrint('Error saving dreams: $e');
      rethrow;
    }
  }

  // Get user's saved dreams
  Future<List<Dream>> getUserDreams() async {
    try {
      final prefs = await _getPrefs();
      final dreamsJson = prefs.getString('userDreams');

      if (dreamsJson != null) {
        final List<dynamic> dreamsList = jsonDecode(dreamsJson);

        final dreams = dreamsList.map((json) {
          debugPrint('Processing dream JSON: $json');
          return Dream.fromMap(json);
        }).toList();

        return dreams;
      }
      return [];
    } catch (e) {
      // Clear corrupted data
      try {
        final prefs = await _getPrefs();
        await prefs.remove('userDreams');
      } catch (clearError) {
        debugPrint('Erro: $clearError');
      }
      return [];
    }
  }

  // Delete a specific dream by ID
  Future<void> deleteDream(String dreamId) async {
    try {
      final dreams = await getUserDreams();

      final updatedDreams = dreams
          .where((dream) => dream.id != dreamId)
          .toList();

      await saveDreams(updatedDreams);
      debugPrint('Dream deleted successfully');
    } catch (e) {
      debugPrint('Error deleting dream: $e');
      rethrow;
    }
  }

  Future<void> clearAll() async {
    try {
      final prefs = await _getPrefs();
      await prefs.clear();
    } catch (e) {
      debugPrint('Error clearing preferences: $e');
      rethrow;
    }
  }

  Future<String?> getString(String key) async {
    try {
      final prefs = await _getPrefs();
      return prefs.getString(key);
    } catch (e) {
      debugPrint('Error getting string for key $key: $e');
      return null;
    }
  }

  Future<void> setString(String key, String value) async {
    try {
      final prefs = await _getPrefs();
      await prefs.setString(key, value);
    } catch (e) {
      debugPrint('Error setting string for key $key: $e');
      rethrow;
    }
  }
}
