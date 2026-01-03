import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/constants/app_colors.dart';
import '../../../../service/dream_service.dart';
import '../../../../model/major_model.dart';
import '../../../../model/university_model.dart';
import '../../../../model/university_major.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text_styles.dart';
import 'package:uni_finder/ui/screens/comapre/compare_screen.dart';
import 'compare_modal_widget/major_search_section.dart';
import 'compare_modal_widget/university_selection_section.dart';
import 'compare_modal_widget/compare_buttons_section.dart';

class CompareUniversitiesBottomSheet extends StatefulWidget {
  final DreamService dreamService;

  const CompareUniversitiesBottomSheet({super.key, required this.dreamService});

  static Future<void> show(BuildContext context, DreamService dreamService) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          CompareUniversitiesBottomSheet(dreamService: dreamService),
    );
  }

  @override
  State<CompareUniversitiesBottomSheet> createState() =>
      _CompareUniversitiesBottomSheetState();
}

class _CompareUniversitiesBottomSheetState
    extends State<CompareUniversitiesBottomSheet> {
  int? selectedMajorId;
  int? university1Id;
  int? university2Id;

  List<Major> majors = [];
  List<Major> filteredMajors = [];
  List<University> availableUniversities = [];
  List<UniversityMajor> universityMajorRelations = [];

  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;
  bool showMajorResults = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        filteredMajors = majors;
        showMajorResults = false;
      } else {
        filteredMajors = majors
            .where(
              (major) => major.name.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ),
            )
            .toList();
        showMajorResults = true;
      }
    });
  }

  Future<void> loadData() async {
    final loadedMajors = await widget.dreamService.getMajorsData();
    final allUniversities = await widget.dreamService.getUniversitiesData();
    final relations = await widget.dreamService.getUniversityMajorsData();

    setState(() {
      majors = loadedMajors;
      filteredMajors = loadedMajors;
      availableUniversities = allUniversities;
      universityMajorRelations = relations;
      filteredUniversities =
          allUniversities; // Initialize with all universities
      isLoading = false;
    });
  }

  void handleCompare() async {
    if (selectedMajorId != null &&
        university1Id != null &&
        university2Id != null) {
      // Get the selected universities
      final uni1 = filteredUniversities.firstWhere(
        (u) => u.id == university1Id,
      );
      final uni2 = filteredUniversities.firstWhere(
        (u) => u.id == university2Id,
      );

      // Get the major
      final major = majors.firstWhere((m) => m.id == selectedMajorId);

      // Get the university-major relations
      final uniMajor1 = universityMajorRelations.firstWhere(
        (um) =>
            um.universityId == university1Id && um.majorId == selectedMajorId,
      );
      final uniMajor2 = universityMajorRelations.firstWhere(
        (um) =>
            um.universityId == university2Id && um.majorId == selectedMajorId,
      );

      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompareScreen(
            university1: uni1,
            university2: uni2,
            selectedMajor: major,
            universityMajor1: uniMajor1,
            universityMajor2: uniMajor2,
          ),
        ),
      );
    }
  }

  List<University> filteredUniversities = [];

  void selectMajor(Major major) async {
    final universities = await widget.dreamService.getUniversitiesForMajor(
      major.id!,
    );
    setState(() {
      selectedMajorId = major.id;
      _searchController.text = major.name;
      university1Id = null;
      university2Id = null;
      filteredUniversities = universities;
      showMajorResults = false;
    });
  }

  void selectFirstUniversity(int universityId) {
    setState(() {
      university1Id = universityId;
    });
  }

  void selectSecondUniversity(int universityId) {
    setState(() {
      university2Id = universityId;
    });
  }

  void resetSelections() {
    setState(() {
      selectedMajorId = null;
      university1Id = null;
      university2Id = null;
      _searchController.clear();
      filteredMajors = majors;
      showMajorResults = false;
    });
  }

  void handleReset() {
    resetSelections();
  }

  void clearSearch() {
    _searchController.clear();
    setState(() {
      showMajorResults = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Compare Universities',
                      style: AppTextStyles.h2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            // Search Major Section
                            MajorSearchSection(
                              searchController: _searchController,
                              filteredMajors: filteredMajors,
                              showMajorResults: showMajorResults,
                              onSearchChanged: (value) => onSearchChanged(),
                              onMajorSelected: selectMajor,
                              onClearSearch: clearSearch,
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            // First University Section
                            UniversitySelectionSection(
                              title: 'First University',
                              universities: filteredUniversities,
                              selectedUniversityId: university1Id,
                              disabledUniversityId: university2Id,
                              isMajorSelected: selectedMajorId != null,
                              onUniversitySelected: selectFirstUniversity,
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            // Second University Section
                            UniversitySelectionSection(
                              title: 'Second University',
                              universities: filteredUniversities,
                              selectedUniversityId: university2Id,
                              disabledUniversityId: university1Id,
                              isMajorSelected: selectedMajorId != null,
                              onUniversitySelected: selectSecondUniversity,
                            ),

                            const SizedBox(height: AppSpacing.xl),
                          ],
                        ),
                      ),
              ),

              // Buttons
              CompareButtonsSection(
                onReset: handleReset,
                onCompare: handleCompare,
                canCompare:
                    selectedMajorId != null &&
                    university1Id != null &&
                    university2Id != null,
              ),
            ],
          ),
        );
      },
    );
  }
}
