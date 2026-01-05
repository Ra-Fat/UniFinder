
import 'package:flutter/material.dart';
import '../../../common/Theme/app_styles.dart';

class OptionCard extends StatelessWidget {
	final String text;
	final bool isSelected;
	final VoidCallback onTap;
	final ValueChanged<bool?>? onChanged;

	const OptionCard({
		super.key,
		required this.text,
		required this.isSelected,
		required this.onTap,
		this.onChanged,
	});

	@override
	Widget build(BuildContext context) {
		return MouseRegion(
			cursor: SystemMouseCursors.click,
			child: GestureDetector(
				onTap: onTap,
				child: Container(
					width: double.infinity,
					margin: const EdgeInsets.symmetric(vertical: 6),
					padding: const EdgeInsets.symmetric(
						horizontal: 16,
						vertical: 14,
					),
					decoration: BoxDecoration(
						color: isSelected
								? AppColors.primaryBlue
								: AppColors.secondaryBackground,
						borderRadius: BorderRadius.circular(14),
						border: Border.all(
							color: isSelected
									? AppColors.accentBlue
									: AppColors.tertiaryBackground,
							width: 1.5,
						),
					),
					child: Row(
						children: [
							Expanded(
								child: Text(
									text,
									style: TextStyle(
										color: Colors.white,
										fontSize: 16,
										fontWeight: FontWeight.w500,
									),
								),
							),
							Checkbox(
								value: isSelected,
								onChanged: onChanged,
								activeColor: Colors.blue,
								checkColor: Colors.white,
							),
						],
					),
				),
			),
		);
	}
}
