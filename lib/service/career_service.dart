import '../Domain/data/repository/career_repository.dart';
import '../Domain/data/repository/relationship_repository.dart';
import '../Domain/model/Career/career_model.dart';

class CareerService {
  final CareerRepository _careerRepository;
  final RelationshipRepository _relationshipRepository;

  CareerService(this._careerRepository, this._relationshipRepository);

  // Get all careers data
  Future<List<Career>> getCareersData() async {
    return await _careerRepository.getCareerData();
  }

  // Get all careers related to a specific major
  Future<List<Career>> getCareersForMajor(String majorId) async {
    final allCareers = await _careerRepository.getCareerData();
    return await _relationshipRepository.getCareersByMajor(majorId, allCareers);
  }
}
