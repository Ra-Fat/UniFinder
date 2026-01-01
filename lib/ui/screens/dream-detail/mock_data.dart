class Career {
  final String id;
  final String name;
  final String shortDescription;
  final List<String> skills;

  Career({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.skills,
  });
}

class University {
  final String id;
  final String name;

  University({required this.id, required this.name});
}

class Major {
  final String id;
  final String name;

  Major({required this.id, required this.name});
}

class UniversityMajor {
  final University university;
  final Major major;
  final String tuitionRange;

  UniversityMajor({
    required this.university,
    required this.major,
    required this.tuitionRange,
  });
}

class Dream {
  final String id;
  final String name;
  final Major primaryMajor;
  final List<Major> relatedMajors;
  final List<Career> careers;

  Dream({
    required this.id,
    required this.name,
    required this.primaryMajor,
    required this.relatedMajors,
    required this.careers,
  });
}

final csMajor = Major(id: 'm1', name: 'Computer Science');
final seMajor = Major(id: 'm2', name: 'Software Engineering');
final itMajor = Major(id: 'm3', name: 'Information Technology');

final rupp = University(id: 'u1', name: 'RUPP');
final itc = University(id: 'u2', name: 'ITC');
final puc = University(id: 'u3', name: 'PUC');

final universityMajors = [
  UniversityMajor(
    university: rupp,
    major: csMajor,
    tuitionRange: '\$500 – \$1,200 / year',
  ),
  UniversityMajor(
    university: itc,
    major: csMajor,
    tuitionRange: '\$800 – \$1,500 / year',
  ),
  UniversityMajor(
    university: puc,
    major: seMajor,
    tuitionRange: '\$1,200 – \$2,000 / year',
  ),
  UniversityMajor(
    university: rupp,
    major: seMajor,
    tuitionRange: '\$700 – \$1,300 / year',
  ),
  UniversityMajor(
    university: itc,
    major: itMajor,
    tuitionRange: '\$600 – \$1,100 / year',
  ),
  UniversityMajor(
    university: puc,
    major: itMajor,
    tuitionRange: '\$1,000 – \$1,800 / year',
  ),
];

final careers = [
  Career(
    id: 'c1',
    name: 'Software Engineer',
    shortDescription: 'Designs and builds software systems.',
    skills: ['Programming', 'Problem Solving'],
  ),
  Career(
    id: 'c2',
    name: 'Data Scientist',
    shortDescription: 'Analyzes data to extract insights.',
    skills: ['Statistics', 'Machine Learning'],
  ),
  Career(
    id: 'c3',
    name: 'UI/UX Designer',
    shortDescription: 'Designs user interfaces and experiences.',
    skills: ['Creativity', 'User Research'],
  ),

  Career(
    id: 'c4',
    name: 'UI/UX Designer',
    shortDescription: 'Designs user interfaces and experiences.',
    skills: ['Creativity', 'User Research'],
  ),
];

final dream = Dream(
  id: 'd1',
  name: 'Childhood Dream',
  primaryMajor: csMajor,
  relatedMajors: [seMajor, itMajor],
  careers: careers,
);
