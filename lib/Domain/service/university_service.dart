import '../data/repository/university_repository.dart';
import '../data/repository/relationship_repository.dart';
import '../data/repository/major_repository.dart';
import '../model/University/university_model.dart';
import '../model/University/university_major.dart';
import '../model/University/universityMajorDetail.dart';

class UniversityService {
  final UniversityRepository _universityRepository;
  final RelationshipRepository _relationshipRepository;
  final MajorRepository _majorRepository;

  UniversityService(
    this._universityRepository,
    this._relationshipRepository,
    this._majorRepository,
  );

  // Get all universities data
  Future<List<University>> getUniversitiesData() async {
    return await _universityRepository.getUniversitiesData();
  }

  // Get university-major relationships
  Future<List<UniversityMajor>> getUniversityMajorsData() async {
    return await _relationshipRepository.getUniversityMajorsData();
  }

  // Get universities offering a specific major
  Future<List<University>> getUniversitiesForMajor(String majorId) async {
    final universityIds =
        (await _relationshipRepository.getUniversityMajorsData())
            .where((relation) => relation.majorId == majorId)
            .map((relation) => relation.universityId)
            .toSet();

    final allUniversities = await _universityRepository.getUniversitiesData();
    return allUniversities
        .where((uni) => universityIds.contains(uni.id))
        .toList();
  }

  // Get all universities offering any of the given majors
  Future<List<UniversityMajorDetail>> getUniversitiesForMajors(
    List<String> majorIds,
  ) async {
    final majorIdSet = majorIds.toSet();
    if (majorIdSet.isEmpty) {
      return [];
    }

    // 1: Get all university-major relationships once
    final universityMajors = await _relationshipRepository
        .getUniversityMajorsData();

    // 2: Get all universities (to lookup names from IDs)
    final universities = await _universityRepository.getUniversitiesData();

    // 3: Get all majors (to lookup names from IDs)
    final majors = await _majorRepository.getMajorsData();

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
}
