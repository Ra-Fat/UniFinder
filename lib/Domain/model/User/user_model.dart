import 'package:uuid/uuid.dart';

var uuid = Uuid();

class User {
  final String? id;
  final String name;

  User({String? id, required this.name}) : id = id ?? uuid.v4();

  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id']?.toString(), name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
