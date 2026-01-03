import 'package:uni_finder/model/major_model.dart';
import 'package:uni_finder/model/university_major.dart';
import 'package:uni_finder/model/university_model.dart';

class UniversityMajorDetail {
  final UniversityMajor universityMajor;
  final University university;
  final Major major;

  UniversityMajorDetail({
    required this.universityMajor,
    required this.university,
    required this.major,
  });

  String get tuitionRange =>
      '\$${universityMajor.pricePerYear.toStringAsFixed(0)} / year';

  String get degreeType => universityMajor.degree;

  int get durationYears => universityMajor.durationYears;
}
