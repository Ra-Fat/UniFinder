import '../model/User/user_model.dart';
import '../data/repository/user_repository.dart';

class UserService {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  // Get single user (current logged-in user)
  Future<User?> getUser() async {
    return await _userRepository.getUser();
  }

  // Save/Update user
  Future<void> saveUser(User user) async {
    return await _userRepository.saveUser(user);
  }
}
