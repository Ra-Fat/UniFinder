import '../storage/file_storage.dart';
import '../../model/career_major.dart';
import '../../model/university_major.dart';
import '../../model/career_model.dart';
import 'package:flutter/foundation.dart';

class RelationshipRepository {
  final FileStorage _fileStorage;

  RelationshipRepository(this._fileStorage);

  // get CareerMajor relationships
  Future<List<CareerMajor>> getCareerMajorsData() async {
    try {
      final data = await _fileStorage.readJsonData('career_majors.json');
      return data
          .map((item) => CareerMajor.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      debugPrint('Error loading career majors: $err');
      return [];
    }
  }

  // get UniversityMajor data
  Future<List<UniversityMajor>> getUniversityMajorsData() async {
    try {
      final data = await _fileStorage.readJsonData('university_majors.json');
      return data
          .map((item) => UniversityMajor.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      debugPrint('Error loading university majors: $err');
      return [];
    }
  }

  // Get careers by major ID
  Future<List<Career>> getCareersByMajor(
    int majorId,
    List<Career> allCareers,
  ) async {
    try {
      final careerMajors = await getCareerMajorsData();

      final careerIds = careerMajors
          .where((cm) => cm.majorId == majorId)
          .map((cm) => cm.careerId)
          .toSet();

      return allCareers.where((c) => careerIds.contains(c.id)).toList();
    } catch (err) {
      debugPrint('Error getting careers by major: $err');
      return [];
    }
  }

  // Get universities offering a specific major
  Future<List<UniversityMajor>> getUniversitiesForMajor(int majorId) async {
    try {
      final universityMajors = await getUniversityMajorsData();
      return universityMajors.where((um) => um.majorId == majorId).toList();
    } catch (err) {
      debugPrint('Error getting universities for major: $err');
      return [];
    }
  }
}
