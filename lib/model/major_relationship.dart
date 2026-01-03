class MajorRelationship {
  final int majorId;
  final int relatedMajorId;

  MajorRelationship({required this.majorId, required this.relatedMajorId});

  factory MajorRelationship.fromMap(Map<String, dynamic> map) {
    return MajorRelationship(
      majorId: map['major_id'] as int,
      relatedMajorId: map['related_major_id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {'major_id': majorId, 'related_major_id': relatedMajorId};
  }
}
