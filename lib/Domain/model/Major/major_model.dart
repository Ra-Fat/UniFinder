class Major {
  final String? id;
  final String name;
  final String categoryId;
  final String description;
  final List<String> keySkills;

  Major({
    this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    this.keySkills = const [],
  });

  factory Major.fromMap(Map<String, dynamic> map) {
    return Major(
      id: map['id'],
      name: map['name'],
      categoryId: map['category_id'],
      description: map['description'],
      keySkills: map['key_skills'] != null
          ? List<String>.from(map['key_skills'])
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
      'description': description,
      'key_skills': keySkills,
    };
  }
}
