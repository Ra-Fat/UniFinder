import '../../../theme/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/widget.dart';

class BottomBar extends StatelessWidget {
	final int currentIndex;
	final int totalQuestions;
	final int selectedOptionIndex;
	final VoidCallback? onPrev;
	final VoidCallback? onNext;
	final VoidCallback? onGenerate;

	const BottomBar({
		Key? key,
		required this.currentIndex,
		required this.totalQuestions,
		required this.selectedOptionIndex,
		this.onPrev,
		this.onNext,
		this.onGenerate,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Container(
			decoration: BoxDecoration(
				color: AppColors.darkBackground,
				border: Border(
					top: BorderSide(color: AppColors.secondaryBackground, width: 1),
				),
			),
			padding: EdgeInsets.all(15),
			child: SafeArea(
				child: currentIndex == totalQuestions - 1
						? CustomizeButton(
								text: 'Generate',
								onPressed: selectedOptionIndex != -1 ? onGenerate : null,
							)
						: Row(
								children: [
									Container(
										width: 55,
										height: 50,
										decoration: BoxDecoration(
											color: AppColors.secondaryBackground.withOpacity(0.5),
											borderRadius: BorderRadius.circular(16),
										),
										child: IconButton(
											onPressed: currentIndex == 0 ? null : onPrev,
											icon: Icon(
												Icons.chevron_left,
												color: Colors.white,
												size: 28,
											),
										),
									),
									SizedBox(width: 12),
									Expanded(
										child: CustomizeButton(
											text: 'Next',
											onPressed: selectedOptionIndex != -1 ? onNext : null,
										),
									),
								],
							),
			),
		);
	}
}
