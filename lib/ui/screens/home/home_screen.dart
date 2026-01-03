import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_finder/model/dreams_model.dart';
import 'package:uni_finder/service/dream_service.dart';
import 'package:uni_finder/service/user_service.dart';
// import 'package:uni_finder/ui/common/constants/app_text_styles.dart';
import 'widget/welcome_header.dart';
// import '../';
import 'widget/dreams_list.dart';
import '../../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  final DreamService dreamService;
  final UserService userService;

  const HomeScreen({
    super.key,
    required this.dreamService,
    required this.userService,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Dream> _dreams = [];
  String _userName = '';
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
    final user = await widget.userService.getUser();

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
      appBar: AppBar(
        title: WelcomeHeader(
          userName: _userName,
          dreamService: widget.dreamService,
          searchController: _searchController,
          onSearchChanged: onSearch,
        ),
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 145,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 0,
            left: 15,
            right: 15,
            bottom: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        backgroundColor: AppColors.accentBlue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: AppColors.textPrimary),
      ),
    );
  }
}
