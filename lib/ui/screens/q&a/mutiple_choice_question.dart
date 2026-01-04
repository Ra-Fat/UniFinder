import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../Domain/model/Quiz/question_model.dart';
import '../../../Domain/model/Quiz/option_model.dart';
import '../../../Domain/model/Quiz/submission_model.dart';
import '../../../Domain/model/Quiz/answer_model.dart';
import '../../../main.dart';
import '../../theme/app_styles.dart';
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
        // check - store option ID instead of index
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
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSecondaryText(
                        text:
                            'Question ${currentIndex + 1} of ${questions.length}',
                        fontSize: 14,
                      ),
                      CustomSecondaryText(
                        text:
                            '${((currentIndex + 1) / questions.length * 100).round()}%',
                        textColor: Colors.blue,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (currentIndex + 1) / questions.length,
                      backgroundColor: AppColors.secondaryBackground,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        toolbarHeight: 70,
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

                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _selectOption(index),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryBlue
                            : AppColors.secondaryBackground,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.accentBlue
                              : AppColors.tertiaryBackground,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option.text,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) => _selectOption(index),
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.darkBackground,
          border: Border(
            top: BorderSide(color: AppColors.secondaryBackground, width: 1),
          ),
        ),
        padding: EdgeInsets.all(15),
        child: SafeArea(
          child: currentIndex == questions.length - 1
              ? CustomizeButton(
                  text: 'Generate',
                  onPressed: selectedOptionIndex != -1
                      ? _goToRecommendationScreen
                      : null,
                )
              : Row(
                  children: [
                    Container(
                      width: 55,
                      height: 50,
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: AppColors.secondaryBackground.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        onPressed: currentIndex == 0 ? null : _goPrevQuestion,
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: CustomizeButton(
                        text: 'Next',
                        onPressed: selectedOptionIndex != -1
                            ? _goNextQuestion
                            : null,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
