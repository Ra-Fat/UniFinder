class Major {
  final String? id;
  final String name;
  final String categoryId;
  final String description;

  Major({
    this.id,
    required this.name,
    required this.categoryId,
    required this.description,
  });

  factory Major.fromMap(Map<String, dynamic> map) {
    return Major(
      id: map['id'],
      name: map['name'],
      categoryId: map['category_id'],
      description: map['description'],
    );
  }

   Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
      'description': description,

    };
  }
}
