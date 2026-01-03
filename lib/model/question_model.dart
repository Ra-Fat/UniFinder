class Question{
  final String id;
  final String text;

  Question({required this.id , required this.text});

  factory Question.fromMap(Map<String, dynamic> map){
    return Question(
      id: map['id'], 
      text: map['text']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'text': text,
    };
  }
}