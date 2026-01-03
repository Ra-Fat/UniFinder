import '../model/user_model.dart';
import '../data/repository/data_repository.dart';

class UserService {
  final DataRepository _repository;

  UserService(this._repository);

  // Get single user (current logged-in user)
  Future<User?> getUser() async {
    return await _repository.getUser();
  }

  // Get all users
  Future<List<User>> getUsers() async {
    return await _repository.getUsers();
  }

  // Save/Update user
  Future<void> saveUser(User user) async {
    return await _repository.saveUser(user);
  }
}