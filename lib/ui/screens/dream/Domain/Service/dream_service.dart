import '../mock_data.dart';

class DreamService {
  final List<Career> allCareers;
  final List<UniversityMajor> allUniversityMajors;
  final List<Major> allMajors;

  DreamService({
    required this.allCareers,
    required this.allUniversityMajors,
    required this.allMajors,
  });

  // Get all careers related to a specific major (Primary)
  List<Career> getCareersForMajor(String majorId) {
    return allCareers.where((career) => career.majorId == majorId).toList();
  }

  // Get all universities offering a specific major
  List<UniversityMajor> getUniversitiesForMajor(String majorId) {
    return allUniversityMajors
        .where((universityMajor) => universityMajor.major.id == majorId)
        .toList();
  }

  // Get related majors for a primary major
  List<Major> getRelatedMajorsForPrimary(String primaryMajorId) {
    //Find the Primary Major
    final primaryMajor = allMajors.firstWhere(
      (major) => major.id == primaryMajorId,
      orElse: () => throw Exception('Major not found: $primaryMajorId'),
    );

    return allMajors
        .where((major) => primaryMajor.relatedMajorIds.contains(major.id))
        .toList();
  }
}
