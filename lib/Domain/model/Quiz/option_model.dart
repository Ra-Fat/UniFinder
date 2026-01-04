class Option {
  final String id;
  final String questionId;
  final String text;
  final String categoryId;
  final int score;

  Option({
    required this.id,
    required this.questionId,
    required this.text,
    required this.categoryId,
    required this.score
  });

  factory Option.fromMap(Map<String , dynamic> map){
    return Option(
      id: map['id'],
      questionId: map['question_id'],
      text: map['text'],
      categoryId: map['category_id'],
      score: map['score'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'question_id': questionId,
      'text': text,
      'category_id': categoryId,
      'score': score,
    };
  }

  
}