import '../storage/file_storage.dart';
import '../../model/University/university_model.dart';
import 'package:flutter/foundation.dart';

class UniversityRepository {
  final FileStorage _fileStorage;

  UniversityRepository(this._fileStorage);

  // get data from universities
  Future<List<University>> getUniversitiesData() async {
    try {
      final data = await _fileStorage.readJsonData('universities.json');
      return data
          .map((item) => University.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      debugPrint('Error loading universities: $err');
      return [];
    }
  }

  // Get university by ID
  Future<University?> getUniversityById(String universityId) async {
    try {
      final universities = await getUniversitiesData();
      return universities.firstWhere(
        (u) => u.id == universityId,
        orElse: () => throw Exception('University not found: $universityId'),
      );
    } catch (err) {
      debugPrint('Error getting university by ID: $err');
      return null;
    }
  }


}
