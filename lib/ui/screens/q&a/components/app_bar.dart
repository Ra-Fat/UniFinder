import 'package:flutter/material.dart';
import '../../../common/widgets/widget.dart';
import '../../../theme/app_styles.dart';

class QuestionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final int totalQuestions;
  const QuestionAppBar({Key? key, required this.currentIndex, required this.totalQuestions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomSecondaryText(
                      text: 'Question ${currentIndex + 1} of ${totalQuestions}',
                      fontSize: 14,
                    ),
                    CustomSecondaryText(
                      text: '${((currentIndex + 1) / totalQuestions * 100).round()}%',
                      textColor: Colors.blue,
                      fontSize: 14,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (currentIndex + 1) / totalQuestions,
                    backgroundColor: AppColors.secondaryBackground,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      toolbarHeight: 70,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
