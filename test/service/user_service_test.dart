import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/service/user_service.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late UserService userService;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userService = UserService(mockUserRepository);
  });

  group('UserService', () {
    group('getUser', () {
      test('should return user when repository returns user', () async {
        // Arrange
        when(mockUserRepository.getUser()).thenAnswer((_) async => testUser);

        // Act
        final result = await userService.getUser();

        // Assert
        expect(result, equals(testUser));
        verify(mockUserRepository.getUser()).called(1);
      });

      test('should return null when repository returns null', () async {
        // Arrange
        when(mockUserRepository.getUser()).thenAnswer((_) async => null);

        // Act
        final result = await userService.getUser();

        // Assert
        expect(result, isNull);
        verify(mockUserRepository.getUser()).called(1);
      });
    });

    group('saveUser', () {
      test('should save user successfully', () async {
        // Arrange
        when(mockUserRepository.saveUser(any)).thenAnswer((_) async => {});

        // Act
        await userService.saveUser(testUser);

        // Assert
        verify(mockUserRepository.saveUser(testUser)).called(1);
      });
    });
  });
}
