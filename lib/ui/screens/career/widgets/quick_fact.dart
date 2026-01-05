import 'package:flutter/material.dart';
import '../../../../Domain/model/Career/career_model.dart';
import '../../../theme/app_styles.dart';

class QuickFactSection extends StatelessWidget {
	final Career career;

	const QuickFactSection({
		super.key,
		required this.career,
	});

	@override
	Widget build(BuildContext context) {
		return Row(
			children: [
				Expanded(
					child: InfoCard(
						icon: Icons.attach_money,
						label: 'Salary Range',
						value: career.salaryRange ?? '-',
					),
				),
				const SizedBox(width: 12),
				Expanded(
					child: InfoCard(
						icon: Icons.lightbulb_outline,
						label: 'Skills',
						value: (career.skills?.length ?? 0).toString(),
					),
				),
			],
		);
	}
}

class InfoCard extends StatelessWidget {
	final IconData icon;
	final String label;
	final String value;

	const InfoCard({
		super.key,
		required this.icon,
		required this.label,
		required this.value,
	});

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.all(12),
			decoration: BoxDecoration(
				color: AppColors.cardBackground,
				borderRadius: BorderRadius.circular(12),
				border: Border.all(color: AppColors.cardBorder),
			),
			child: Column(
				children: [
					Icon(icon, size: 24, color: AppColors.primaryBlue),
					const SizedBox(height: 8),
					Text(
						value,
						style: const TextStyle(
							fontSize: 14,
							fontWeight: FontWeight.bold,
							color: Colors.white,
						),
					),
					Text(
						label,
						style: TextStyle(fontSize: 12, color: Colors.grey[400]),
					),
				],
			),
		);
	}
}