class Answer {
  final String questionId;
  final String selectedOptionId;

  Answer({required this.questionId, required this.selectedOptionId});

  // Serialization for SharedPreferences
  Map<String, dynamic> toMap() {
    return {'questionId': questionId, 'selectedOptionId': selectedOptionId};
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      questionId: map['questionId'] as String,
      selectedOptionId: map['selectedOptionId'] as String,
    );
  }
}
