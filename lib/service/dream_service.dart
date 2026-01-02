import 'package:uni_finder/data/repository/data_repository.dart';
import 'package:uni_finder/model/career_model.dart';
import 'package:uni_finder/model/dreams_model.dart';
import 'package:uni_finder/model/major_model.dart';
import 'package:uni_finder/model/university_model.dart';
import 'package:uni_finder/model/university_major.dart';
import 'package:uni_finder/model/universityMajorDetail.dart';
import 'package:uni_finder/model/user_model.dart';

class DreamService {
  final DataRepository _repository;

  DreamService(this._repository);

  // Get all dreams for a user
  Future<List<Dream>> getDreams() async {
    return await _repository.getDreams();
  }

  // Get all users
  Future<List<User>> getUsers() async {
    return await _repository.getUsers();
  }

  // Get single user (for offline app with one user)
  Future<User?> getUser() async {
    return await _repository.getUser();
  }

  // Get all careers related to a specific major
  Future<List<Career>> getCareersForMajor(int majorId) async {
    return await _repository.getCareersByMajor(majorId);
  }

  // Get all universities offering any of the given majors
  Future<List<UniversityMajorDetail>> getUniversitiesForMajors(
    List<int> majorIds,
  ) async {
    final majorIdSet = majorIds.toSet();
    if (majorIdSet.isEmpty) {
      return [];
    }

    // 1: Get all university-major relationships once
    final universityMajors = await _repository.getUniversityMajorsData();

    // 2: Get all universities (to lookup names from IDs)
    final universities = await _repository.getUniversitiesData();

    // 3: Get all majors (to lookup names from IDs)
    final majors = await _repository.getMajorsData();

    // 4: Filter relationships by the requested majors
    final filtered = universityMajors.where(
      (um) => majorIdSet.contains(um.majorId),
    );

    // 5: Combine into UI details
    return filtered.map((um) {
      final university = universities.firstWhere(
        (u) => u.id == um.universityId,
        orElse: () =>
            throw Exception('University not found: ${um.universityId}'),
      );

      final major = majors.firstWhere(
        (m) => m.id == um.majorId,
        orElse: () => throw Exception('Major not found: ${um.majorId}'),
      );

      return UniversityMajorDetail(
        universityMajor: um,
        university: university,
        major: major,
      );
    }).toList();
  }

  // Get major by ID
  Future<Major?> getMajorById(int majorId) async {
    return await _repository.getMajorById(majorId);
  }

  // Get related majors for a primary major
  Future<List<Major>> getRelatedMajorsForPrimary(int majorId) async {
    return await _repository.getRelatedMajors(majorId);
  }

  // Get all majors data
  Future<List<Major>> getMajorsData() async {
    return await _repository.getMajorsData();
  }

  // Get all universities data
  Future<List<University>> getUniversitiesData() async {
    return await _repository.getUniversitiesData();
  }

  // Get university-major relationships
  Future<List<UniversityMajor>> getUniversityMajorsData() async {
    return await _repository.getUniversityMajorsData();
  }

  // Get all careers data
  Future<List<Career>> getCareersData() async {
    return await _repository.getCareerData();
  }

  // Get universities offering a specific major
  Future<List<University>> getUniversitiesForMajor(int majorId) async {
    final universityIds = (await _repository.getUniversityMajorsData())
        .where((relation) => relation.majorId == majorId)
        .map((relation) => relation.universityId)
        .toSet();

    final allUniversities = await _repository.getUniversitiesData();
    return allUniversities
        .where((uni) => universityIds.contains(uni.id))
        .toList();
  }
}
