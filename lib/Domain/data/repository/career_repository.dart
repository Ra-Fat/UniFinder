import '../storage/file_storage.dart';
import '../../model/Career/career_model.dart';
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
  Future<Career?> getCareerById(String careerId) async {
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

}
