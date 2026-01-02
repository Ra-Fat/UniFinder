import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../model/question_model.dart';
import '../../../model/option_model.dart';
import '../../../main.dart';
import '../../widgets/widget.dart';
import '../../theme/app_colors.dart';

class MutipleChoiceQuestionScreen extends StatefulWidget {
  const MutipleChoiceQuestionScreen({super.key});

  @override
  State<MutipleChoiceQuestionScreen> createState() =>
      _MutipleChoiceQuestionScreenState();
}

class _MutipleChoiceQuestionScreenState
    extends State<MutipleChoiceQuestionScreen> {
  List<Question> questions = [];
  Map<int, List<Option>> allOptionsPerQuestion = {};

  // keep track of current question show in the screen
  int currentIndex = 0;
  bool isLoading = true;
  Map<int, int> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  // Get Question data
  Future<void> _loadQuestions() async {
    try {
      final fetchQuestions = await dataRepository.getQuestionData();
      final optionsPerQuestion = await dataRepository.getOptionsByQuestion();

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

    setState(() {
      if (selectedOptions[questionId] == optionIndex) {
        // uncheck
        selectedOptions.remove(questionId);
      } else {
        // check
        selectedOptions[questionId] = optionIndex;
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

  void _goToRecommendationScreen() {
    context.go('/recommendation');
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
    final selectedOptionIndex = selectedOptions[currentQuestion.id] ?? -1;

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
                        text: 'Question ${currentIndex + 1} of ${questions.length}',
                        fontSize: 14,
                      ),
                      CustomSecondaryText(
                        text: '${((currentIndex + 1) / questions.length * 100).round()}%',
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
            CustomPrimaryText(
              text: currentQuestion.text,
            ),
            SizedBox(height: 8),
            CustomSecondaryText(
              text: "Select one option"
            ),
            SizedBox(height: 8),
            if (currentOptions.isEmpty)
              CustomSecondaryText(
                text: 'No options available'
              )
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
          border: Border(top: BorderSide(color: AppColors.secondaryBackground, width: 1)),
        ),
        padding: EdgeInsets.all(15),
        child: SafeArea(
          child: currentIndex == questions.length - 1
              ? CustomizeButton(
                  text: 'Generate',
                  onPressed: _goToRecommendationScreen,
                )
              : Row(
                  children: [
                    Container(
                      width: 55,
                      height: 50,
                      decoration: BoxDecoration(
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
