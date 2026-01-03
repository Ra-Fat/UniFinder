import '../storage/file_storage.dart';
import '../../model/career_model.dart';
import 'package:flutter/foundation.dart';
class CareerRepository {
  final FileStorage _fileStorage;

  CareerRepository(this._fileStorage);

  // get Careers data
  Future<List<Career>> getCareerData() async {
    try {
      final data = await _fileStorage.readJsonData('careers.json');
      return data
          .map((item) => Career.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (err) {
      debugPrint('Error loading Careers: $err');
      return [];
    }
  }

  // Get career by ID
  Future<Career?> getCareerById(int careerId) async {
    try {
      final careers = await getCareerData();
      return careers.firstWhere(
        (c) => c.id == careerId,
        orElse: () => throw Exception('Career not found: $careerId'),
      );
    } catch (err) {
      debugPrint('Error getting career by ID: $err');
      return null;
    }
  }

  // Search careers by name
  Future<List<Career>> searchCareers(String query) async {
    try {
      final careers = await getCareerData();
      return careers
          .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (err) {
      debugPrint('Error searching careers: $err');
      return [];
    }
  }
}
