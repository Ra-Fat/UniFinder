class Submission {
  final int? id;
  final int userId;
  final int questionId;
  final int selectedOptionId;

  Submission({
    this.id,
    required this.userId,
    required this.questionId,
    required this.selectedOptionId,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'user_id': userId,
      'question_id': questionId,
      'selected_option_id': selectedOptionId,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Submission.fromMap(Map<String, dynamic> map) {
    return Submission(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      questionId: map['question_id'] as int,
      selectedOptionId: map['selected_option_id'] as int,
    );
  }
}
