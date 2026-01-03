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
      final userDreams = await _prefsStorage.getUserDreams();
      return [...userDreams];
    } catch (err) {
      debugPrint('Error loading dreams: $err');
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

  Future<void> deleteDream(String dreamId) async {
    try {
      await _prefsStorage.deleteDream(dreamId);
    } catch (err) {
      debugPrint('Error deleting dream: $err');
      rethrow;
    }
  }
}
