class Answer {
  final int userId;
  final int optionId;

  Answer({required this.userId, required this.optionId});

  Map<String, dynamic> toMap() => {
    'user_id': userId,
    'option_id': optionId,
  };

  factory Answer.fromMap(Map<String, dynamic> map) => Answer(
    userId: map['user_id'],
    optionId: map['option_id'],
  );

  
}
