import 'package:flutter/material.dart';
import '../../../constants/app_spacing.dart';
import '../../../../common/widgets/widget.dart';
import '../../../../theme/app_styles.dart';

class CompareButtonsSection extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback? onCompare;
  final bool canCompare;

  const CompareButtonsSection({
    super.key,
    required this.onReset,
    required this.onCompare,
    required this.canCompare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
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
              child: CustomizeButton(
                text: 'Reset',
                onPressed: onReset,
                backgroundColor: Colors.red,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomizeButton(
                text: 'Compare',
                onPressed: canCompare ? onCompare : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
