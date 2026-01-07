import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_finder/service/dream_service.dart';
import 'package:uni_finder/Domain/model/Dream/dreams_model.dart';
import '../test_utils/mock_repositories.mocks.dart';
import '../test_utils/test_data.dart';

void main() {
  late DreamService dreamService;
  late MockDreamRepository mockDreamRepository;

  setUp(() {
    mockDreamRepository = MockDreamRepository();
    dreamService = DreamService(mockDreamRepository);
  });

  group('DreamService', () {
    group('getDreams', () {
      test('should return list of dreams', () async {
        // Arrange
        when(
          mockDreamRepository.getDreams(),
        ).thenAnswer((_) async => testDreams);

        // Act
        final result = await dreamService.getDreams();

        // Assert
        expect(result, equals(testDreams));
        verify(mockDreamRepository.getDreams()).called(1);
      });

      test('should return empty list when no dreams', () async {
        // Arrange
        when(mockDreamRepository.getDreams()).thenAnswer((_) async => []);

        // Act
        final result = await dreamService.getDreams();

        // Assert
        expect(result, isEmpty);
        verify(mockDreamRepository.getDreams()).called(1);
      });
    });

    group('getDreamById', () {
      test('should return dream when ID exists', () async {
        // Arrange
        when(
          mockDreamRepository.getDreams(),
        ).thenAnswer((_) async => testDreams);

        // Act
        final result = await dreamService.getDreamById('1');

        // Assert
        expect(result, isNotNull);
        expect(result!.id, '1');
        expect(result.title, 'Become a Software Engineer');
        verify(mockDreamRepository.getDreams()).called(1);
      });

      test('should return null when dream ID does not exist', () async {
        // Arrange
        when(
          mockDreamRepository.getDreams(),
        ).thenAnswer((_) async => testDreams);

        // Act
        final result = await dreamService.getDreamById('nonexistent');

        // Assert
        expect(result, isNull);
        verify(mockDreamRepository.getDreams()).called(1);
      });

      test('should return null when dreams list is empty', () async {
        // Arrange
        when(mockDreamRepository.getDreams()).thenAnswer((_) async => []);

        // Act
        final result = await dreamService.getDreamById('1');

        // Assert
        expect(result, isNull);
        verify(mockDreamRepository.getDreams()).called(1);
      });
    });

    group('saveDream', () {
      test('should call repository saveDream method', () async {
        // Arrange
        final newDream = Dream(
          id: '3',
          userId: 'user1',
          majorId: 'cs',
          note: 'New dream description',
          createdAt: DateTime.now(),
          title: 'New Dream',
        );

        when(
          mockDreamRepository.saveDream(newDream),
        ).thenAnswer((_) async => {});

        // Act
        await dreamService.saveDream(newDream);

        // Assert
        verify(mockDreamRepository.saveDream(newDream)).called(1);
      });

      test('should handle repository errors gracefully', () async {
        // Arrange
        final newDream = Dream(
          id: '3',
          userId: 'user1',
          majorId: 'cs',
          note: 'New dream description',
          createdAt: DateTime.now(),
          title: 'New Dream',
        );

        when(
          mockDreamRepository.saveDream(newDream),
        ).thenThrow(Exception('Save failed'));

        // Act & Assert
        expect(
          () => dreamService.saveDream(newDream),
          throwsA(isA<Exception>()),
        );
        verify(mockDreamRepository.saveDream(newDream)).called(1);
      });
    });

    group('deleteDream', () {
      test('should call repository deleteDream method', () async {
        // Arrange
        const dreamId = '1';
        when(
          mockDreamRepository.deleteDream(dreamId),
        ).thenAnswer((_) async => {});

        // Act
        await dreamService.deleteDream(dreamId);

        // Assert
        verify(mockDreamRepository.deleteDream(dreamId)).called(1);
      });

      test('should handle repository errors gracefully', () async {
        // Arrange
        const dreamId = '1';
        when(
          mockDreamRepository.deleteDream(dreamId),
        ).thenThrow(Exception('Delete failed'));

        // Act & Assert
        expect(
          () => dreamService.deleteDream(dreamId),
          throwsA(isA<Exception>()),
        );
        verify(mockDreamRepository.deleteDream(dreamId)).called(1);
      });
    });

    group('Integration scenarios', () {
      test('should handle save and retrieve cycle', () async {
        // Arrange
        final newDream = Dream(
          id: '3',
          userId: 'user1',
          majorId: 'cs',
          note: 'Testing save and retrieve',
          createdAt: DateTime.now(),
          title: 'Integration Test Dream',
        );

        final allDreams = [...testDreams, newDream];

        when(
          mockDreamRepository.saveDream(newDream),
        ).thenAnswer((_) async => {});
        when(
          mockDreamRepository.getDreams(),
        ).thenAnswer((_) async => allDreams);

        // Act
        await dreamService.saveDream(newDream);
        final retrievedDream = await dreamService.getDreamById('3');

        // Assert
        expect(retrievedDream, isNotNull);
        expect(retrievedDream!.id, '3');
        expect(retrievedDream.title, 'Integration Test Dream');
        verify(mockDreamRepository.saveDream(newDream)).called(1);
        verify(mockDreamRepository.getDreams()).called(1);
      });

      test('should handle delete and verify removal', () async {
        // Arrange
        const dreamIdToDelete = '1';
        final dreamsAfterDelete = testDreams
            .where((d) => d.id != dreamIdToDelete)
            .toList();

        when(
          mockDreamRepository.deleteDream(dreamIdToDelete),
        ).thenAnswer((_) async => {});
        when(
          mockDreamRepository.getDreams(),
        ).thenAnswer((_) async => dreamsAfterDelete);

        // Act
        await dreamService.deleteDream(dreamIdToDelete);
        final retrievedDream = await dreamService.getDreamById(dreamIdToDelete);

        // Assert
        expect(retrievedDream, isNull);
        verify(mockDreamRepository.deleteDream(dreamIdToDelete)).called(1);
        verify(mockDreamRepository.getDreams()).called(1);
      });
    });
  });
}
