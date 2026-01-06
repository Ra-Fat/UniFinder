import 'package:flutter/material.dart';
import 'package:uni_finder/Domain/model/Dream/dreams_model.dart';
import 'package:uni_finder/ui/common/Theme/app_spacing.dart';
import 'package:uni_finder/ui/common/Theme/app_text_styles.dart';
import 'package:uni_finder/ui/common/widgets/widget.dart';
import 'dream_card.dart';
import 'package:uni_finder/service/dream_service.dart';
import 'package:flutter/foundation.dart';
import '../../../common/Theme/app_styles.dart';

class DreamsList extends StatelessWidget {
  final List<Dream> dreams;
  final bool isLoading;
  final String searchQuery;
  final DreamService? dreamService;
  final void Function(String dreamId)? onDreamDeleted;

  const DreamsList({
    super.key,
    required this.dreams,
    required this.isLoading,
    required this.searchQuery,
    this.dreamService,
    this.onDreamDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.md),
        if (dreams.isNotEmpty) const Text('Your Dream'),
        const SizedBox(height: AppSpacing.md),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : dreams.isEmpty
            ? SizedBox(
                height: 300,
                child: Center(
                  child: Card(
                    color: AppColors.cardBackground,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: AppColors.cardBorder, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 32,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.data_exploration,
                            size: 48,
                            color: AppColors.primaryBlue,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            searchQuery.isEmpty
                                ? 'No dreams yet. Add one!'
                                : 'No dreams found.',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dreams.length,
                itemBuilder: (context, index) {
                  final dream = dreams[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: DreamCard(
                      dream: dream,
                      onDismissed: (direction) async {
                        if (dreamService != null) {
                          await dreamService!.deleteDream(dream.id!);
                        }
                        if (onDreamDeleted != null) {
                          onDreamDeleted!(dream.id!);
                        }
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const CustomSecondaryText(
                                text: 'Dream deleted successfully!',
                              ),
                              backgroundColor: AppColors.cardBackground,
                              behavior: SnackBarBehavior.fixed,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                        if (kDebugMode) {
                          print('Dream deleted: ${dream.id}');
                        }
                      },
                    ),
                  );
                },
              ),
      ],
    );
  }
}
