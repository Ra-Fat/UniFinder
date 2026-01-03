import 'dart:convert';
import 'package:flutter/widgets.dart';
import '../../model/dreams_model.dart';
import '../../model/user_model.dart';
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
      await prefs.setString('user', userJson);
    } catch (e) {
      debugPrint('Error saving user: $e');
      rethrow;
    }
  }

  Future<User?> getUser() async {
    try {
      final prefs = await _getPrefs();
      final userJson = prefs.getString('user');
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
      await prefs.setString('userDreams', jsonEncode(dreamsJson));
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
        return dreamsList.map((json) => Dream.fromMap(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting dreams: $e');
      return [];
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
}
