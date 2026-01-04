class MajorRelationship {
  final String majorId;
  final String relatedMajorId;

  MajorRelationship({required this.majorId, required this.relatedMajorId});

  factory MajorRelationship.fromMap(Map<String, dynamic> map) {
    return MajorRelationship(
      majorId: map['major_id'].toString(),
      relatedMajorId: map['related_major_id'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'major_id': majorId, 'related_major_id': relatedMajorId};
  }
}
