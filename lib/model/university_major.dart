class UniversityMajor {
  final int? id;
  final int universityId;
  final int majorId;
  final double pricePerYear;
  final int durationYears;
  final String degree;

  UniversityMajor({
    this.id,
    required this.universityId,
    required this.majorId,
    required this.pricePerYear,
    required this.durationYears,
    required this.degree,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'university_id': universityId,
      'major_id': majorId,
      'price_per_year': pricePerYear,
      'duration_years': durationYears,
      'degree': degree,
    };
  }

  factory UniversityMajor.fromMap(Map<String, dynamic> map) {
    return UniversityMajor(
      id: map['id'],
      universityId: map['university_id'],
      majorId: map['major_id'],
      pricePerYear: map['price_per_year'],
      durationYears: map['duration_years'],
      degree: map['degree'],
    );
  }

}