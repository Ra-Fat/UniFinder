class Recommendation {
  final int? id;
  final int userId;
  final int careerId;    
  final int universityId;
  final int majorId;     
  final String explanation;

  Recommendation({
    this.id,
    required this.userId,
    required this.careerId,
    required this.universityId,
    required this.majorId,
    this.explanation = '',
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'user_id': userId,
      'career_id': careerId,
      'university_id': universityId,
      'major_id': majorId,
      'explanation': explanation,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Recommendation.fromMap(Map<String, dynamic> map) {
    return Recommendation(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      careerId: map['career_id'] as int,
      universityId: map['university_id'] as int,
      majorId: map['major_id'] as int,
      explanation: map['explanation'] as String? ?? '',
    );
  }
}
