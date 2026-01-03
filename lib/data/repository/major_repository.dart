import 'package:flutter/foundation.dart';

import '../storage/file_storage.dart';
import '../../model/major_model.dart';
import '../../model/major_relationship.dart';

class MajorRepository {
  final FileStorage _fileStorage;

  MajorRepository(this._fileStorage);

  // get Major data
  Future<List<Major>> getMajorsData() async {
    try {
      final data = await _fileStorage.readJsonData('majors.json');
      return data
          .map((item) => Major.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      debugPrint('Error loading Majors: $err');
      return [];
    }
  }

  // Get major by ID
  Future<Major?> getMajorById(int majorId) async {
    try {
      final majors = await getMajorsData();
      return majors.firstWhere(
        (m) => m.id == majorId,
        orElse: () => throw Exception('Major not found: $majorId'),
      );
    } catch (err) {
      debugPrint('Error getting major by ID: $err');
      return null;
    }
  }

  // Get majors by IDs (batch operation)
  Future<List<Major>> getMajorsByIds(List<int> majorIds) async {
    try {
      final majors = await getMajorsData();
      return majors.where((m) => majorIds.contains(m.id)).toList();
    } catch (err) {
      debugPrint('Error getting majors by IDs: $err');
      return [];
    }
  }

  // Search majors by name
  Future<List<Major>> searchMajors(String query) async {
    try {
      final majors = await getMajorsData();
      return majors
          .where((m) => m.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (err) {
      debugPrint('Error searching majors: $err');
      return [];
    }
  }

  // Get related majors for a given major
  Future<List<Major>> getRelatedMajors(int majorId) async {
    try {
      final relationships = await getMajorRelationships();
      final majors = await getMajorsData();

      final relatedIds = relationships[majorId] ?? [];
      return majors.where((m) => relatedIds.contains(m.id)).toList();
    } catch (err) {
      debugPrint('Error getting related majors: $err');
      return [];
    }
  }

  // get Major relationships data
  Future<List<MajorRelationship>> getMajorRelationshipsData() async {
    try {
      final data = await _fileStorage.readJsonData('major_relationships.json');
      return data
          .map(
            (item) => MajorRelationship.fromMap(item as Map<String, dynamic>),
          )
          .toList();
    } catch (err) {
      debugPrint('Error loading major relationships: $err');
      return [];
    }
  }

  // get Major relationships
  Future<Map<int, List<int>>> getMajorRelationships() async {
    try {
      final relationships = await getMajorRelationshipsData();
      final Map<int, List<int>> grouped = {};

      for (var relationship in relationships) {
        // Group related major IDs by majorId 
        grouped
            .putIfAbsent(relationship.majorId, () => [])
            .add(relationship.relatedMajorId);
      }

      return grouped;
    } catch (err) {
      debugPrint('Error loading major relationships: $err');
      return {};
    }
  }
}
