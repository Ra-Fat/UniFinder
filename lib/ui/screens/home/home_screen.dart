import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_finder/model/dreams_model.dart';
import 'package:uni_finder/service/dream_service.dart';
import 'package:uni_finder/ui/common/constants/app_colors.dart';
import 'package:uni_finder/ui/common/constants/app_spacing.dart';
import 'package:uni_finder/ui/common/constants/app_text_styles.dart';
import 'widget/welcome_header.dart';
import 'widget/search_field.dart';
import 'widget/dreams_list.dart';

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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dreams = await widget.dreamService.getDreams();
    final user = await widget.dreamService.getUser();

    setState(() {
      _dreams = dreams;
      _userName = user?.name ?? 'User';
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void onSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  List<Dream> get _filteredDreams {
    if (_searchQuery.isEmpty) {
      return _dreams;
    }
    final q = _searchQuery.toLowerCase();
    return _dreams
        .where((dream) => dream.title?.toLowerCase().contains(q) ?? false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              WelcomeHeader(
                userName: _userName,
                dreamService: widget.dreamService,
              ),
              Text(
                'Discover your dream here',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: AppSpacing.xxl),
              SearchField(controller: _searchController, onChanged: onSearch),
              const SizedBox(height: AppSpacing.md),
              DreamsList(
                dreams: _filteredDreams,
                isLoading: _isLoading,
                searchQuery: _searchQuery,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/questions');
        },
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
