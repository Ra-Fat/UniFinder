import 'package:flutter/rendering.dart';

import '../storage/shared_preferences_storage.dart';
import '../../model/User/user_model.dart';

class UserRepository {
  final SharedPreferencesStorage _prefsStorage;

  UserRepository(this._prefsStorage);

  // get single user (from SharedPreferences)
  Future<User?> getUser() async {
    try {
      return await _prefsStorage.getUser();
    } catch (err) {
      debugPrint('Error getting user: $err');
      return null;
    }
  }

  // save user data (to SharedPreferences)
  Future<void> saveUser(User user) async {
    try {
      await _prefsStorage.saveUser(user);
    } catch (err) {
      debugPrint('Error saving user: $err');
      rethrow;
    }
  }
}
