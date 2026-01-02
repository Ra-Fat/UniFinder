import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_finder/ui/app.dart';
import '../../widgets/widget.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widget.dart';
import './major_card.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({super.key});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  int? selectedCardIndex;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dreamNameController = TextEditingController();

  void _selectedDream(int index) {
    setState(() {
      selectedCardIndex = selectedCardIndex == index ? null : index;
    });
  }

  @override
  void dispose() {
    _dreamNameController.dispose();
    super.dispose();
  }

  void _handleSaveDream() {
    if (_formKey.currentState!.validate()) {
      String dreamName = _dreamNameController.text.trim();
      Navigator.of(context).pop();
      _dreamNameController.clear();
      context.go('/home');
    }
  }

  String? _validateDreamName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a dream name';
    }
    if (value.trim().length < 3) {
      return 'Dream name must be at least 3 characters';
    }
    return null;
  }

  void _showDreamNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.darkBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.accentBlue.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPrimaryText(text: "Name Your Dream"),
                  SizedBox(height: 6),
                  CustomSecondaryText(
                    text: "Give ur ... dream a memorable name",
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _dreamNameController,
                    validator: _validateDreamName,

                    decoration: InputDecoration(
                      label: Text("e.g., My Childhood dream" , style: TextStyle(fontSize: 14),),
                      contentPadding: const EdgeInsets.symmetric(vertical: 13 , horizontal: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CustomizeButton(
                          text: "Cancel",
                          
                          backgroundColor: AppColors.disabled,
                          onPressed: () {
                            _dreamNameController.clear();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: CustomizeButton(
                          text: "Save Dream",
                          backgroundColor: AppColors.primaryBlue,
                          onPressed: _handleSaveDream,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomPrimaryText(text: "Your Perfect Majors"),
                  SizedBox(height: 8),
                  CustomSecondaryText(
                    text: 'Choose one major to save as your dream',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              MajorCard(
                majorName: 'Software Engineering',
                isSelected: selectedCardIndex == 0,
                description:
                    'Build innovative applications and systems that shape the digital world',
                matchScore: 95.0,
                studyDuration: 4,
                keySkills: [
                  'Problem Solving',
                  'Critical Thinking',
                  'Collaboration',
                ],
                universitiesOffer: 10,
                onTab: () => _selectedDream(0),
              ),
            ],
          ),
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
          child: CustomizeButton(
            text: "Save as My dream",
            onPressed: () {
              if (selectedCardIndex != null) {
                _showDreamNameDialog();
              }
            },
            backgroundColor: selectedCardIndex != null
                ? AppColors.primaryBlue
                : AppColors.disabled,
          ),
        ),
      ),
    );
  }
}
