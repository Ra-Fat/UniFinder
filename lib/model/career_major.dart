class CareerMajor {
  final String careerId;
  final String majorId;

  CareerMajor({required this.careerId, required this.majorId});

  Map<String, dynamic> toMap() => {
    'career_id': careerId,
    'major_id': majorId,
  };

  factory CareerMajor.fromMap(Map<String, dynamic> map) => CareerMajor(
    careerId: map['career_id'],
    majorId: map['major_id'],
  );
}
