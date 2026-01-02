import 'package:flutter/material.dart';
import '../../../service/dream_service.dart';
import '../../../model/major_model.dart';
import '../../../model/university_model.dart';
import '../../../model/university_major.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_colors.dart';
import 'package:uni_finder/ui/screens/comapre/compare_screen.dart';

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
  List<University> availableUniversities = [];
  List<UniversityMajor> universityMajorRelations = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final loadedMajors = await widget.dreamService.getMajorsData();
    final allUniversities = await widget.dreamService.getUniversitiesData();
    final relations = await widget.dreamService.getUniversityMajorsData();

    setState(() {
      majors = loadedMajors;
      availableUniversities = allUniversities;
      universityMajorRelations = relations;
      filteredUniversities =
          allUniversities; // Initialize with all universities
      isLoading = false;
    });
  }

  void _handleCompare() {
    if (selectedMajorId != null &&
        university1Id != null &&
        university2Id != null) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CompareScreen()),
      );
    }
  }

  List<University> filteredUniversities = [];

  void _selectMajor(int? value) async {
    if (value != null) {
      final universities = await widget.dreamService.getUniversitiesForMajor(
        value,
      );
      setState(() {
        selectedMajorId = value;
        university1Id = null;
        university2Id = null;
        filteredUniversities = universities;
      });
    }
  }

  void _selectFirstUniversity(int universityId) {
    setState(() {
      university1Id = universityId;
    });
  }

  void _selectSecondUniversity(int universityId) {
    setState(() {
      university2Id = universityId;
    });
  }

  void _resetSelections() {
    setState(() {
      selectedMajorId = null;
      university1Id = null;
      university2Id = null;
    });
  }

  void _handleReset() {
    _resetSelections();
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
            color: Colors.grey[50],
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
                            // Select Major Section
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1.5,
                                ),
                              ),
                              child: DropdownButtonFormField<int>(
                                initialValue: selectedMajorId,
                                menuMaxHeight: 300,
                                dropdownColor: Colors.white,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Select a major',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                                items: majors
                                    .map(
                                      (major) => DropdownMenuItem(
                                        value: major.id,
                                        child: Text(major.name),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) => _selectMajor(value),
                              ),
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            // First University Section
                            Text(
                              'First University',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),

                            if (selectedMajorId == null)
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Please select a major first',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            else
                              ...filteredUniversities.map((uni) {
                                final isSelected = university1Id == uni.id;
                                final isDisabled = university2Id == uni.id;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: GestureDetector(
                                    onTap: isDisabled
                                        ? null
                                        : () => _selectFirstUniversity(uni.id!),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: isDisabled
                                            ? Colors.grey[200]
                                            : (isSelected
                                                  ? AppColors.primary
                                                  : Colors.white),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isDisabled
                                              ? Colors.grey[300]!
                                              : (isSelected
                                                    ? AppColors.primary
                                                    : Colors.grey[300]!),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              uni.name,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: isDisabled
                                                    ? Colors.grey[400]
                                                    : (isSelected
                                                          ? AppColors.white
                                                          : Colors.grey[800]),
                                              ),
                                            ),
                                          ),
                                          if (isSelected)
                                            const Icon(
                                              Icons.check_circle,
                                              color: AppColors.white,
                                              size: 20,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),

                            const SizedBox(height: AppSpacing.xl),

                            // Second University Section
                            Text(
                              'Second University',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),

                            if (selectedMajorId == null)
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Please select a major first',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            else
                              ...filteredUniversities.map((uni) {
                                final isSelected = university2Id == uni.id;
                                final isDisabled = university1Id == uni.id;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: GestureDetector(
                                    onTap: isDisabled
                                        ? null
                                        : () =>
                                              _selectSecondUniversity(uni.id!),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: isDisabled
                                            ? Colors.grey[200]
                                            : (isSelected
                                                  ? AppColors.primary
                                                  : Colors.white),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isDisabled
                                              ? Colors.grey[300]!
                                              : (isSelected
                                                    ? AppColors.primary
                                                    : Colors.grey[300]!),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              uni.name,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: isDisabled
                                                    ? Colors.grey[400]
                                                    : (isSelected
                                                          ? AppColors.white
                                                          : Colors.grey[800]),
                                              ),
                                            ),
                                          ),
                                          if (isSelected)
                                            const Icon(
                                              Icons.check_circle,
                                              color: AppColors.white,
                                              size: 20,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),

                            const SizedBox(height: AppSpacing.xl),
                          ],
                        ),
                      ),
              ),

              // Buttons
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(205),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _handleReset,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                              selectedMajorId != null &&
                                  university1Id != null &&
                                  university2Id != null
                              ? _handleCompare
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Compare',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  selectedMajorId != null &&
                                      university1Id != null &&
                                      university2Id != null
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
