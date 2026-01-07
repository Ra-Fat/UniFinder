import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../common/widgets/widget.dart';
import '../../common/Theme/app_styles.dart';
import '../../../Domain/model/Dream/dreams_model.dart';
import 'components/major_card.dart';
import 'components/input_name_dialog.dart';
import 'components/app_bar.dart';
import 'components/bottom_bar.dart';
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


  Future<void> _handleSaveDream(String dreamName) async {
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
        'Dream saved successfully: [${newDream.title} (ID: ${newDream.id})',
      );
      if (mounted) {
        context.go('/home');
      }
    } catch (err) {
      debugPrint('Error saving dream: $err');
    }
  }

  void _showDreamNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputNameDialog(onSave: _handleSaveDream);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RecommendationAppBar(),
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
                      keySkills: rec.major.keySkills,
                      onTab: () => _selectedDream(index, rec.major.id ?? ''),
                    );
                  }),
                ),
              ),
      ),
      bottomNavigationBar: RecommendationBottomBar(
        enabled: selectedCardIndex != null,
        onPressed: selectedCardIndex != null ? _showDreamNameDialog : null,
      ),
    );
  }
}
