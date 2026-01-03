import 'package:flutter/rendering.dart';

import '../storage/file_storage.dart';
import '../storage/shared_preferences_storage.dart';
import '../../model/dreams_model.dart';

class DreamRepository {
  final FileStorage _fileStorage;
  final SharedPreferencesStorage _prefsStorage;

  DreamRepository(this._fileStorage, this._prefsStorage);

  Future<List<Dream>> getDreams() async {
    try {
      final defaultDreams = await _fileStorage.readJsonData('dreams.json');
      final jsonDreams = defaultDreams
          .map((item) => Dream.fromMap(item as Map<String, dynamic>))
          .toList();

      // Get user-created dreams from SharedPreferences
      final userDreams = await _prefsStorage.getUserDreams();

      // Combine both lists
      return [...jsonDreams, ...userDreams];
    } catch (err) {
      print('Error loading dreams: $err');
      return [];
    }
  }

  Future<void> saveDream(Dream dream) async {
    try {
      final currentUserDreams = await _prefsStorage.getUserDreams();
      currentUserDreams.add(dream);
      await _prefsStorage.saveDreams(currentUserDreams);
    } catch (err) {
      debugPrint('Error saving dream: $err');
      rethrow;
    }
  }
}
