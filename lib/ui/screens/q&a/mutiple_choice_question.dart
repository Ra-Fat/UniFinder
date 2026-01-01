import 'package:flutter/material.dart';
import '../../../model/question_model.dart';
import '../../../model/option_model.dart';
import '../../../main.dart';

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
        backgroundColor: Color(0xFF0f172a),
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
                      Text(
                        'Question ${currentIndex + 1} of ${questions.length}',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${((currentIndex + 1) / questions.length * 100).round()}%',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (currentIndex + 1) / questions.length,
                      backgroundColor: Color(0xFF1e293b),
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
            Text(
              currentQuestion.text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Select one option",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            SizedBox(height: 8),
            if (currentOptions.isEmpty)
              Text('No options available', style: TextStyle(color: Colors.grey))
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
                            ? const Color(0xFF1e40af)
                            : const Color(0xFF1e293b),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? Colors.blue
                              : const Color(0xFF334155),
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
          color: Color(0xFF0f172a),
          border: Border(top: BorderSide(color: Color(0xFF1e293b), width: 1)),
        ),
        padding: EdgeInsets.all(15),
        child: SafeArea(
          child: currentIndex == questions.length - 1
              ? SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 17, 55, 144),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Generate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Row(
                  children: [
                    Container(
                      width: 55,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF1e293b).withOpacity(0.5),
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
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: selectedOptionIndex != -1
                              ? Color.fromARGB(255, 17, 55, 144)
                              : Color(0xFF374151),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ElevatedButton(
                          onPressed: selectedOptionIndex != -1
                              ? _goNextQuestion
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            disabledBackgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.chevron_right, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
