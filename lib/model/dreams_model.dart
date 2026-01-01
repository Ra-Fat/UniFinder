class Dream{
  final int? id;
  final int userId; 
  final int majorId;
  final String? note; 

  Dream({
    this.id,
    required this.userId,
    required this.majorId,
    this.note,
  });

  factory Dream.fromMap(Map<String, dynamic> map) {
    return Dream(
      id: map['id'],
      userId: map['user_id'],
      majorId: map['major_id'],
      note: map['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'major_id': majorId,
      'note': note,
    };
  }
}