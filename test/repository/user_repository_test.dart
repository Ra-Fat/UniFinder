import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/Domain/data/repository/user_repository.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late UserRepository userRepository;
  late MockSharedPreferencesStorage mockSharedPreferencesStorage;

  setUp(() {
    mockSharedPreferencesStorage = MockSharedPreferencesStorage();
    userRepository = UserRepository(mockSharedPreferencesStorage);
  });

  group('UserRepository', () {
    group('getUser', () {
      test('should return user when data exists', () async {
        // Arrange
        when(
          mockSharedPreferencesStorage.getUser(),
        ).thenAnswer((_) async => testUser);

        // Act
        final result = await userRepository.getUser();

        // Assert
        expect(result, equals(testUser));
        verify(mockSharedPreferencesStorage.getUser()).called(1);
      });

      test('should return null when no user data exists', () async {
        // Arrange
        when(
          mockSharedPreferencesStorage.getUser(),
        ).thenAnswer((_) async => null);

        // Act
        final result = await userRepository.getUser();

        // Assert
        expect(result, isNull);
        verify(mockSharedPreferencesStorage.getUser()).called(1);
      });

      test('should return null when storage throws error', () async {
        // Arrange
        when(
          mockSharedPreferencesStorage.getUser(),
        ).thenThrow(Exception('Storage error'));

        // Act
        final result = await userRepository.getUser();

        // Assert
        expect(result, isNull);
        verify(mockSharedPreferencesStorage.getUser()).called(1);
      });
    });

    group('saveUser', () {
      test('should save user successfully', () async {
        // Arrange
        when(
          mockSharedPreferencesStorage.saveUser(any),
        ).thenAnswer((_) async => {});

        // Act
        await userRepository.saveUser(testUser);

        // Assert
        verify(mockSharedPreferencesStorage.saveUser(testUser)).called(1);
      });
    });
  });
}
