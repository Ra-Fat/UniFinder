
import 'package:flutter/material.dart';
import '../../../common/widgets/widget.dart';
import '../../../common/Theme/app_styles.dart';

class RecommendationAppBar extends StatelessWidget implements PreferredSizeWidget {
	const RecommendationAppBar({super.key});

	@override
	Widget build(BuildContext context) {
		return AppBar(
			backgroundColor: AppColors.darkBackground,
			elevation: 0,
			scrolledUnderElevation: 0,
			surfaceTintColor: Colors.transparent,
			title: Row(
				children: [
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								CustomPrimaryText(text: "Your Perfect Majors"),
								SizedBox(height: 8),
								CustomSecondaryText(
									text: 'Choose one major to save as your dream',
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
