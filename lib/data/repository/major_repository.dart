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
      print('Error loading Majors: $err');
      return [];
    }
  }

  // Get major by ID
  Future<Major?> getMajorById(String majorId) async {
    try {
      final majors = await getMajorsData();
      return majors.firstWhere(
        (m) => m.id == majorId,
        orElse: () => throw Exception('Major not found: $majorId'),
      );
    } catch (err) {
      print('Error getting major by ID: $err');
      return null;
    }
  }

  // Get majors by IDs (batch operation)
  Future<List<Major>> getMajorsByIds(List<String> majorIds) async {
    try {
      final majors = await getMajorsData();
      return majors.where((m) => majorIds.contains(m.id)).toList();
    } catch (err) {
      print('Error getting majors by IDs: $err');
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
      print('Error searching majors: $err');
      return [];
    }
  }

  // Get related majors for a given major
  Future<List<Major>> getRelatedMajors(String majorId) async {
    try {
      // Convert string ID to int for relationship lookup
      final int? numericId = int.tryParse(majorId);
      if (numericId == null) {
        print('Cannot parse major ID to int: $majorId');
        return [];
      }
      
      final relationships = await getMajorRelationships();
      final majors = await getMajorsData();

      final relatedIds = relationships[numericId] ?? [];
      return majors.where((m) => relatedIds.contains(int.tryParse(m.id ?? ''))).toList();
    } catch (err) {
      print('Error getting related majors: $err');
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
      print('Error loading major relationships: $err');
      return [];
    }
  }

  // get Major relationships
  Future<Map<int, List<int>>> getMajorRelationships() async {
    try {
      final relationships = await getMajorRelationshipsData();
      final Map<int, List<int>> grouped = {};

      for (var relationship in relationships) {
        grouped
            .putIfAbsent(relationship.majorId, () => [])
            .add(relationship.relatedMajorId);
      }

      return grouped;
    } catch (err) {
      print('Error loading major relationships: $err');
      return {};
    }
  }
}
