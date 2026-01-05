import 'package:flutter/material.dart';
import '../../../common/Theme/app_styles.dart';
import '../../../common/widgets/widget.dart';

class RecommendationBottomBar extends StatelessWidget {
	final bool enabled;
	final VoidCallback? onPressed;

	const RecommendationBottomBar({
		super.key,
		required this.enabled,
		required this.onPressed,
	});

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
				child: CustomizeButton(
					text: "Save as My dream",
					onPressed: enabled ? onPressed : null,
					backgroundColor: enabled
							? AppColors.primaryBlue
							: AppColors.disabled,
				),
			),
		);
	}
}
