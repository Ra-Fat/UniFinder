import 'package:flutter/material.dart';
import 'package:uni_finder/ui/common/constants/app_colors.dart';
import 'package:uni_finder/ui/common/widgets/widget.dart';
import '../../../../service/dream_service.dart';
import '../../../../service/major_service.dart';
import '../../../../service/university_service.dart';
import '../../../../Domain/model/Major/major_model.dart';
import '../../../../Domain/model/University/university_model.dart';
import '../../../../Domain/model/University/university_major.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text_styles.dart';
import 'package:uni_finder/ui/screens/comapre/compare_screen.dart';
import 'compare_modal_widget/major_search_section.dart';
import 'compare_modal_widget/university_selection_section.dart';
import 'compare_modal_widget/compare_buttons_section.dart';

class CompareUniversitiesBottomSheet extends StatefulWidget {
  final DreamService dreamService;
  final MajorService majorService;
  final UniversityService universityService;

  const CompareUniversitiesBottomSheet({
    super.key,
    required this.dreamService,
    required this.majorService,
    required this.universityService,
  });

  // Shows the comparison modal as a bottom sheet
  // Requires all three services to load majors, universities, and relationships
  static Future<void> show(
    BuildContext context,
    DreamService dreamService,
    MajorService majorService,
    UniversityService universityService,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CompareUniversitiesBottomSheet(
        dreamService: dreamService,
        majorService: majorService,
        universityService: universityService,
      ),
    );
  }

  @override
  State<CompareUniversitiesBottomSheet> createState() =>
      _CompareUniversitiesBottomSheetState();
}

class _CompareUniversitiesBottomSheetState
    extends State<CompareUniversitiesBottomSheet> {
  // Selected IDs for the comparison
  String? selectedMajorId;
  String? university1Id;
  String? university2Id;

  // Data lists loaded from services
  List<Major> majors = [];
  List<Major> filteredMajors = [];
  List<University> availableUniversities = [];
  List<UniversityMajor> universityMajorRelations = [];

  // UI state
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;
  bool showMajorResults = false;

  @override
  void initState() {
    super.initState();
    loadData(); // Load all required data when modal opens
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Shows search results when user types, hides when search is empty
  // Handles search input changes and filters majors accordingly
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

  /// Loads all necessary data for the comparison
  Future<void> loadData() async {
    final loadedMajors = await widget.majorService.getMajorsData();
    final allUniversities = await widget.universityService
        .getUniversitiesData();
    final relations = await widget.universityService.getUniversityMajorsData();

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

  // Processes the comparison when user clicks compare button
  // Finds the selected universities and major, gets their relationship data,
  // then navigates to the detailed comparison screen
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

      // Get the university-major relations (contains tuition, requirements, etc.)
      final uniMajor1 = universityMajorRelations.firstWhere(
        (um) =>
            um.universityId == university1Id && um.majorId == selectedMajorId,
      );
      final uniMajor2 = universityMajorRelations.firstWhere(
        (um) =>
            um.universityId == university2Id && um.majorId == selectedMajorId,
      );

      Navigator.pop(context); // Close the modal

      // Navigate to comparison screen with all selected data
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

  // Called when user selects a major from search results
  // Filters universities to only show those that offer the selected major
  // Resets university selections since major changed
  void selectMajor(Major major) async {
    final universities = await widget.universityService.getUniversitiesForMajor(
      major.id!,
    );
    setState(() {
      selectedMajorId = major.id;
      _searchController.text = major.name;
      university1Id = null; // Reset selections
      university2Id = null;
      filteredUniversities = universities;
      showMajorResults = false;
    });
  }

  // Selects the first university for comparison
  void selectFirstUniversity(String universityId) {
    setState(() {
      university1Id = universityId;
    });
  }

  // Selects the second university for comparison
  void selectSecondUniversity(String universityId) {
    setState(() {
      university2Id = universityId;
    });
  }

  // Resets all selections back to initial state
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
      initialChildSize: 0.8, // Modal takes 90% of screen height initially
      minChildSize: 0.4, // Can be dragged down to 50%
      maxChildSize: 0.95, // Can be dragged up to 95%
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

              // Header with title and close button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomPrimaryText(
                    text:   'Compare Universities',
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              // Main content area
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Search section for selecting a major
                            MajorSearchSection(
                              searchController: _searchController,
                              filteredMajors: filteredMajors,
                              showMajorResults: showMajorResults,
                              onSearchChanged: (value) => onSearchChanged(),
                              onMajorSelected: selectMajor,
                              onClearSearch: clearSearch,
                            ),

                            const SizedBox(height: AppSpacing.md),

                            // First university selection section
                            UniversitySelectionSection(
                              title: 'First University',
                              universities: filteredUniversities,
                              selectedUniversityId: university1Id,
                              disabledUniversityId:
                                  university2Id, // Can't select same as second
                              isMajorSelected: selectedMajorId != null,
                              onUniversitySelected: selectFirstUniversity,
                            ),

                            const SizedBox(height: AppSpacing.md),

                            // Second university selection section
                            UniversitySelectionSection(
                              title: 'Second University',
                              universities: filteredUniversities,
                              selectedUniversityId: university2Id,
                              disabledUniversityId:
                                  university1Id, // Can't select same as first
                              isMajorSelected: selectedMajorId != null,
                              onUniversitySelected: selectSecondUniversity,
                            ),

                            const SizedBox(height: AppSpacing.xl),
                          ],
                        ),
                      ),
              ),

              // Bottom action buttons (Reset and Compare)
              CompareButtonsSection(
                onReset: handleReset,
                onCompare: handleCompare,
                canCompare:
                    selectedMajorId != null && // All three must be selected
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
