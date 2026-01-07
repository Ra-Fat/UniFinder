import 'answer_model.dart';

class Submission {
  final String id;
  final String userId;
  final List<Answer> answers;
  final DateTime completedAt;

  Submission({
    required this.id,
    required this.userId,
    required this.answers,
    required this.completedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'answers': answers.map((a) => a.toMap()).toList(),
      'completedAt': completedAt.toIso8601String(),
    };
  }

  factory Submission.fromMap(Map<String, dynamic> map) {
    return Submission(
      id: map['id'] as String,
      userId: map['userId'] as String,
      answers: (map['answers'] as List)
          .map((a) => Answer.fromMap(a as Map<String, dynamic>))
          .toList(),
      completedAt: DateTime.parse(map['completedAt'] as String),
    );
  }
}
