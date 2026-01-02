class Career {
  final int? id;
  final String name;
  final String description;

  Career({this.id, required this.name, required this.description});

  factory Career.fromMap(Map<String, dynamic> map) => Career(
    id: map['id'],
    name: map['name'],
    description: map['description'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
  };
}
