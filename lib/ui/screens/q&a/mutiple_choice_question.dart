import 'components/app_bar.dart';
import 'components/bottom_bar.dart';
import 'components/option_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../Domain/model/Quiz/question_model.dart';
import '../../../Domain/model/Quiz/option_model.dart';
import '../../../Domain/model/Quiz/submission_model.dart';
import '../../../Domain/model/Quiz/answer_model.dart';
import '../../../main.dart';
import '../../common/widgets/widget.dart';

class MutipleChoiceQuestionScreen extends StatefulWidget {
  const MutipleChoiceQuestionScreen({super.key});

  @override
  State<MutipleChoiceQuestionScreen> createState() =>
      _MutipleChoiceQuestionScreenState();
}

class _MutipleChoiceQuestionScreenState
    extends State<MutipleChoiceQuestionScreen> {
  List<Question> questions = [];
  Map<String, List<Option>> allOptionsPerQuestion = {};

  // keep track of current question show in the screen
  int currentIndex = 0;
  bool isLoading = true;
  // Changed: Store selected option ID instead of index
  Map<String, String> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  // Get Question data
  Future<void> _loadQuestions() async {
    try {
      final fetchQuestions = await questionService.getQuestionData();
      final optionsPerQuestion = await questionService.getOptionsByQuestion();

      // need more checked on it
      if (!mounted) return;

      setState(() {
        questions = fetchQuestions;
        allOptionsPerQuestion = optionsPerQuestion;
        isLoading = false;
      });
    } catch (err) {
      debugPrint('Error loading questions: $err');
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _selectOption(int optionIndex) {
    final questionId = questions[currentIndex].id;
    final currentOptions = allOptionsPerQuestion[questionId] ?? [];
    final selectedOptionId = currentOptions[optionIndex].id;

    setState(() {
      if (selectedOptions[questionId] == selectedOptionId) {
        // uncheck
        selectedOptions.remove(questionId);
      } else {
        // check
        selectedOptions[questionId] = selectedOptionId;
      }
    });
  }

  void _goNextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void _goPrevQuestion() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  Future<void> _goToRecommendationScreen() async {
    try {
      // Get current user
      final user = await userService.getUser();
      if (user == null) {
        debugPrint('No user found');
        return;
      }

      // Create list of Answer objects from selected options
      final answers = selectedOptions.entries.map((entry) {
        return Answer(questionId: entry.key, selectedOptionId: entry.value);
      }).toList();

      // Create submission
      final submission = Submission(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user.id ?? '',
        answers: answers,
        completedAt: DateTime.now(),
      );

      // Save submission
      await questionService.saveSubmission(submission);
      debugPrint('Submission saved successfully');

      if (mounted) {
        context.go('/recommendation');
      }
    } catch (err) {
      debugPrint('Error saving submission: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (questions.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'No questions found',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final currentQuestion = questions[currentIndex];
    final currentOptions = allOptionsPerQuestion[currentQuestion.id] ?? [];
    // Changed: Find selected option by ID instead of index
    final selectedOptionId = selectedOptions[currentQuestion.id];
    final selectedOptionIndex = selectedOptionId != null
        ? currentOptions.indexWhere((opt) => opt.id == selectedOptionId)
        : -1;

    return Scaffold(
      appBar: QuestionAppBar(
        currentIndex: currentIndex,
        totalQuestions: questions.length,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPrimaryText(text: currentQuestion.text),
            SizedBox(height: 8),
            CustomSecondaryText(text: "Select one option"),
            SizedBox(height: 8),
            if (currentOptions.isEmpty)
              CustomSecondaryText(text: 'No options available')
            else
              ...List.generate(currentOptions.length, (index) {
                final option = currentOptions[index];
                final isSelected = selectedOptionIndex == index;
                return OptionCard(
                  text: option.text,
                  isSelected: isSelected,
                  onTap: () => _selectOption(index),
                  onChanged: (_) => _selectOption(index),
                );
              }),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        totalQuestions: questions.length,
        selectedOptionIndex: selectedOptionIndex,
        onPrev: _goPrevQuestion,
        onNext: _goNextQuestion,
        onGenerate: _goToRecommendationScreen,
      ),
    );
  }
}
