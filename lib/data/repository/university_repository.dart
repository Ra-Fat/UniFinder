import '../storage/file_storage.dart';
import '../../model/university_model.dart';

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
      print('Error loading universities: $err');
      return [];
    }
  }

  // Get university by ID
  Future<University?> getUniversityById(int universityId) async {
    try {
      final universities = await getUniversitiesData();
      return universities.firstWhere(
        (u) => u.id == universityId,
        orElse: () => throw Exception('University not found: $universityId'),
      );
    } catch (err) {
      print('Error getting university by ID: $err');
      return null;
    }
  }

  // Search universities by name
  Future<List<University>> searchUniversities(String query) async {
    try {
      final universities = await getUniversitiesData();
      return universities
          .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (err) {
      print('Error searching universities: $err');
      return [];
    }
  }
}
