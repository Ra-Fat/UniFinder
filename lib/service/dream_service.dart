import 'package:uni_finder/data/repository/dream_repository.dart';
import 'package:uni_finder/model/dreams_model.dart';

class DreamService {
  final DreamRepository _dreamRepository;

  DreamService(this._dreamRepository);

  // Get all dreams for a user
  Future<List<Dream>> getDreams() async {
    return await _dreamRepository.getDreams();
  }

  // Save a new dream
  Future<void> saveDream(Dream dream) async {
    await _dreamRepository.saveDream(dream);
  }
}
