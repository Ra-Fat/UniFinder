class University{
  final String? id;       
  final String name; 
  final String? shortName;
  final String location;
  final String description;
  final String type;
  final int establishedYear;
  final String website;
  final String logoPath;
  final String email;
  final String coverImagePath;
  final String phone;

  University({
    this.id,
    required this.name,
    this.shortName,
    required this.description,
    required this.location,
    required this.type,
    required this.establishedYear,
    required this.website,
    required this.phone,
    required this.email,
    required this.logoPath,
    required this.coverImagePath,
  });

  factory University.fromMap(Map<String, dynamic> map) {
    return University(
      id: map['id'],
      name: map['name'],
      shortName: map['short_name'],
      description: map['description'],
      location: map['location'],
      type: map['type'],
      establishedYear: map['established_year'],
      website: map['website'],
      phone: map['phone'],
      email: map['email'],
      logoPath: map['logo_path'],
      coverImagePath: map['cover_image_path'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'description': description,
      'location': location,
      'type': type,
      'established_year': establishedYear,
      'website': website,
      'phone': phone,
      'email': email,
      'logo_path': logoPath,
      'cover_image_path': coverImagePath,
    };
  }


}