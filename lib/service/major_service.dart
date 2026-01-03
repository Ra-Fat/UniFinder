import '../../data/repository/major_repository.dart';
import '../../model/major_model.dart';

class MajorService {
  final MajorRepository _majorRepository;

  MajorService(this._majorRepository);

  // Get all majors data
  Future<List<Major>> getMajorsData() async {
    return await _majorRepository.getMajorsData();
  }

  // Get major by ID
  Future<Major?> getMajorById(int majorId) async {
    return await _majorRepository.getMajorById(majorId);
  }

  // Get related majors for a primary major
  Future<List<Major>> getRelatedMajorsForPrimary(int majorId) async {
    return await _majorRepository.getRelatedMajors(majorId);
  }
}
