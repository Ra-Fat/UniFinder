import 'package:uni_finder/Domain/model/University/university_model.dart';
import 'package:uni_finder/Domain/model/University/university_major.dart';
import 'package:uni_finder/Domain/model/University/universityMajorDetail.dart';
import 'package:uni_finder/Domain/model/Major/major_model.dart';
import 'package:uni_finder/Domain/model/Dream/dreams_model.dart';
import 'package:uni_finder/Domain/model/Category/category_model.dart';
import 'package:uni_finder/Domain/model/Quiz/question_model.dart';
import 'package:uni_finder/Domain/model/Quiz/option_model.dart';
import 'package:uni_finder/Domain/model/Quiz/submission_model.dart';
import 'package:uni_finder/Domain/model/Quiz/answer_model.dart';
import 'package:uni_finder/Domain/model/User/user_model.dart';
import 'package:uni_finder/Domain/model/Career/career_model.dart';
import 'package:uni_finder/Domain/model/Career/career_major.dart';
import 'package:uni_finder/Domain/model/Major/major_recommendation_model.dart';

// Test data for universities
final testUniversities = [
  University(
    id: '1',
    name: 'Royal University of Phnom Penh',
    shortName: 'RUPP',
    location: 'Phnom Penh',
    description: 'Leading public university in Cambodia',
    type: 'Public',
    establishedYear: 1960,
    website: 'https://www.rupp.edu.kh',
    phone: '+855 23 123 456',
    email: 'info@rupp.edu.kh',
    logoPath: 'university/rupp_logo.png',
    coverImagePath: 'university/rupp_cover.jpg',
  ),
  University(
    id: '2',
    name: 'Institute of Technology of Cambodia',
    shortName: 'ITC',
    location: 'Phnom Penh',
    description: 'Premier technology institute in Cambodia',
    type: 'Public',
    establishedYear: 1964,
    website: 'https://www.itc.edu.kh',
    phone: '+855 23 654 321',
    email: 'info@itc.edu.kh',
    logoPath: 'university/itc_logo.png',
    coverImagePath: 'university/itc_cover.jpg',
  ),
];

// Test data for majors
final testMajors = [
  Major(
    id: 'cs',
    name: 'Computer Science',
    categoryId: 'tech',
    description: 'Study of computers and computational systems',
    keySkills: ['Programming', 'Algorithms', 'Data Structures'],
  ),
  Major(
    id: 'eng',
    name: 'Engineering',
    categoryId: 'tech',
    description: 'Application of science and mathematics',
    keySkills: ['Mathematics', 'Physics', 'Problem Solving'],
  ),
];

// Test data for university-major relationships
final testUniversityMajors = [
  UniversityMajor(
    id: '1',
    universityId: '1',
    majorId: 'cs',
    pricePerYear: 1000,
    durationYears: 4,
    degree: 'Bachelor',
  ),
  UniversityMajor(
    id: '2',
    universityId: '1',
    majorId: 'eng',
    pricePerYear: 1200,
    durationYears: 4,
    degree: 'Bachelor',
  ),
  UniversityMajor(
    id: '3',
    universityId: '2',
    majorId: 'cs',
    pricePerYear: 900,
    durationYears: 4,
    degree: 'Bachelor',
  ),
];

// Test data for dreams
final testDreams = [
  Dream(
    id: '1',
    userId: 'user1',
    majorId: 'cs',
    note: 'I want to develop mobile applications',
    createdAt: DateTime.now(),
    title: 'Become a Software Engineer',
  ),
  Dream(
    id: '2',
    userId: 'user1',
    majorId: 'eng',
    note: 'Build infrastructure for the country',
    createdAt: DateTime.now(),
    title: 'Civil Engineering Career',
  ),
];

// Test data for categories
final testCategories = [
  Category(id: 'tech', name: 'Technology'),
  Category(id: 'business', name: 'Business'),
];

// Test data for questions
final testQuestions = [
  Question(id: 'q1', text: 'What type of work environment do you prefer?'),
  Question(id: 'q2', text: 'How do you feel about mathematics?'),
];

// Test data for options
final testOptions = [
  Option(
    id: 'o1',
    questionId: 'q1',
    text: 'Working with computers and technology',
    categoryId: 'tech',
    score: 10,
  ),
  Option(
    id: 'o2',
    questionId: 'q1',
    text: 'Working with people and business',
    categoryId: 'business',
    score: 8,
  ),
  Option(
    id: 'o3',
    questionId: 'q2',
    text: 'I love mathematics',
    categoryId: 'tech',
    score: 9,
  ),
];

// Test data for submissions
final testSubmissions = [
  Submission(
    id: 's1',
    userId: 'user1',
    answers: [
      Answer(questionId: 'q1', selectedOptionId: 'o1'),
      Answer(questionId: 'q2', selectedOptionId: 'o3'),
    ],
    completedAt: DateTime.now(),
  ),
];

// Test data for users
final testUser = User(id: 'user1', name: 'John Doe');

// Test data for careers
final testCareers = [
  Career(
    id: 'career1',
    name: 'Software Engineer',
    description: 'Develops software applications',
    shortDescription: 'Software development',
    salaryRange: '\$80,000 - \$150,000',
    imagePath: 'career/software_engineer.jpg',
    skills: ['Programming', 'Problem Solving', 'Teamwork'],
    careerProgression: {'Junior': 'Senior', 'Senior': 'Lead'},
  ),
  Career(
    id: 'career2',
    name: 'Civil Engineer',
    description: 'Designs and builds infrastructure',
    shortDescription: 'Infrastructure design',
    salaryRange: '\$70,000 - \$120,000',
    imagePath: 'career/civil_engineer.jpg',
    skills: ['Mathematics', 'Project Management', 'Design'],
    careerProgression: {
      'Engineer': 'Senior Engineer',
      'Senior': 'Project Manager',
    },
  ),
];

// Test data for career-major relationships
final testCareerMajors = [
  CareerMajor(careerId: 'career1', majorId: 'cs'),
  CareerMajor(careerId: 'career2', majorId: 'eng'),
];

// Test data for major recommendations
final testMajorRecommendations = [
  MajorRecommendation(
    major: testMajors[0], // Computer Science
    matchScore: 85.0,
  ),
  MajorRecommendation(
    major: testMajors[1], // Engineering
    matchScore: 65.0,
  ),
];

// Helper function to create UniversityMajorDetail
UniversityMajorDetail createTestUniversityMajorDetail(
  UniversityMajor universityMajor,
  University university,
  Major major,
) {
  return UniversityMajorDetail(
    universityMajor: universityMajor,
    university: university,
    major: major,
  );
}
