class Career {
  final String? id;
  final String name;
  final String description;
  final String? shortDescription;
  final String? salaryRange;
  final List<String>? skills;
  final Map<String, String>? careerProgression;

  Career({
    this.id,
    required this.name,
    required this.description,
    this.shortDescription,
    this.salaryRange,
    this.skills,
    this.careerProgression,
  });

  factory Career.fromMap(Map<String, dynamic> map) => Career(
    id: map['id'],
    name: map['name'],
    description: map['description'],
    shortDescription: map['short_description'],
    salaryRange: map['salary_range'],
    skills: map['skills'] != null ? List<String>.from(map['skills']) : null,
    careerProgression: map['career_progression'] != null
        ? Map<String, String>.from(map['career_progression'])
        : null,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'short_description': shortDescription,
    'salary_range': salaryRange,
    'skills': skills,
    'career_progression': careerProgression,
  };
}
