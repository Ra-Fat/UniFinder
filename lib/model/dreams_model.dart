class Dream {
  final int? id;
  final int userId;
  final int majorId;
  final String? note;
  final DateTime createdAt;
  final String? title;

  Dream({
    this.id,
    required this.userId,
    required this.majorId,
    this.note,
    DateTime? createdAt,
    this.title,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Dream.fromMap(Map<String, dynamic> map) {
    return Dream(
      id: map['id'],
      userId: map['user_id'],
      majorId: map['major_id'],
      note: map['note'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'major_id': majorId,
      'note': note,
      'created_at': createdAt.toIso8601String(),
      'title': title,
    };
  }
}
