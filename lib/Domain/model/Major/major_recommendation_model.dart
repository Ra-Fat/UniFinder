import 'package:uni_finder/Domain/model/Major/major_model.dart';
class MajorRecommendation {
  final Major major;
  final double matchScore;

  MajorRecommendation({
    required this.major,
    required this.matchScore,
  });
}
