import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_finder/model/dreams_model.dart';
import 'package:uni_finder/service/dream_service.dart';
import 'package:uni_finder/ui/common/constants/app_colors.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/common/constants/app_text_styles.dart';
import 'widget/dream_card.dart';
import 'package:uni_finder/ui/common/widgets/compare_universities_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  final DreamService dreamService;

  const HomeScreen({super.key, required this.dreamService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Dream> _dreams = [];
  String _userName = 'User';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dreams = await widget.dreamService.getDreams();
    final users = await widget.dreamService.getUsers();

    setState(() {
      _dreams = dreams;
      // Use first user if available, otherwise default to 'User'
      _userName = users.isNotEmpty ? users.first.name : 'User';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.paddingTop,
                left: AppSpacing.paddingHorizontal,
                right: AppSpacing.paddingHorizontal,
                bottom: AppSpacing.xxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('Welcome,', style: AppTextStyles.h1White),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            _userName,
                            style: AppTextStyles.h1.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.compare_arrows),
                        tooltip: 'Compare',
                        onPressed: () {
                          CompareUniversitiesBottomSheet.show(
                            context,
                            widget.dreamService,
                          );
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Discover your dream here',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: const Icon(Icons.search, size: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusXl,
                        ),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text('Your Dream'),
                  const SizedBox(height: AppSpacing.md),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _dreams.isEmpty
                      ? const Center(
                          child: Text(
                            'No dreams yet. Add one!',
                            style: AppTextStyles.bodySmall,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _dreams.length,
                          itemBuilder: (context, index) {
                            return DreamCard(dream: _dreams[index]);
                          },
                        ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: AppSpacing.lg,
            right: AppSpacing.lg,
            child: FloatingActionButton(
              onPressed: () {
                context.push('/questions');
              },
              backgroundColor: AppColors.primary,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
