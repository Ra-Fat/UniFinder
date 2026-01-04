import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../common/widgets/widget.dart';
import '../../theme/app_styles.dart';
import '../../../Domain/model/Dream/dreams_model.dart';
import './major_card.dart';
import 'package:uuid/uuid.dart';
import 'package:uni_finder/Domain/model/Major/major_recommendation_model.dart';
import '../../../service/recommendation_service.dart';
import '../../../service/user_service.dart';
import '../../../service/dream_service.dart';

class Recommendation extends StatefulWidget {
  final RecommendationService recommendationService;
  final UserService userService;
  final DreamService dreamService;

  const Recommendation({
    super.key,
    required this.recommendationService,
    required this.userService,
    required this.dreamService,
  });

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  int? selectedCardIndex;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dreamNameController = TextEditingController();
  String? selectedMajorId;
  List<MajorRecommendation> recommendations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    try {
      final user = await widget.userService.getUser();
      if (user != null) {
        final recs = await widget.recommendationService.generateRecommendations(
          user.id ?? '',
        );
        setState(() {
          recommendations = recs;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (err) {
      debugPrint('Error loading recommendations: $err');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _selectedDream(int index, String majorId) {
    setState(() {
      final isCurrentlySelected = selectedCardIndex == index;
      selectedCardIndex = isCurrentlySelected ? null : index;
      selectedMajorId = isCurrentlySelected ? null : majorId;
    });
  }

  @override
  void dispose() {
    _dreamNameController.dispose();
    super.dispose();
  }

  Future<void> _handleSaveDream() async {
    if (_formKey.currentState!.validate()) {
      final dreamName = _dreamNameController.text.trim();

      // get current user
      final user = await widget.userService.getUser();

      final newDream = Dream(
        id: const Uuid().v4(), // Generate unique ID
        title: dreamName,
        userId: user?.id ?? 'User',
        majorId: selectedMajorId!,
      );

      try {
        await widget.dreamService.saveDream(newDream);
        debugPrint(
          'Dream saved successfully: ${newDream.title} (ID: ${newDream.id})',
        );

        if (mounted) {
          Navigator.of(context).pop();
          _dreamNameController.clear();
          context.go('/home');
        }
      } catch (err) {
        debugPrint('Error saving dream: $err');
      }
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
                  CustomSecondaryText(text: "Give your dream a name"),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _dreamNameController,
                    validator: _validateDreamName,

                    decoration: InputDecoration(
                      label: Text(
                        "e.g., My Childhood dream",
                        style: TextStyle(fontSize: 14),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 8,
                      ),
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : recommendations.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: AppColors.disabled),
                    SizedBox(height: 16),
                    CustomPrimaryText(text: "No Recommendations Found"),
                    SizedBox(height: 8),
                    CustomSecondaryText(text: "Please complete the quiz first"),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: List.generate(recommendations.length, (index) {
                    final rec = recommendations[index];
                    return MajorCard(
                      majorName: rec.major.name,
                      isSelected: selectedCardIndex == index,
                      description: rec.major.description,
                      matchScore: double.parse(
                        rec.matchScore.toStringAsFixed(2),
                      ),
                      // studyDuration: rec.major.duration,
                      keySkills: rec.major.keySkills,
                      // universitiesOffer: rec.major.universityCount,
                      onTab: () => _selectedDream(index, rec.major.id ?? ''),
                    );
                  }),
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
