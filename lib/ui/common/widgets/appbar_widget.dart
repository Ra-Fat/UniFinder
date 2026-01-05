
import 'package:flutter/material.dart';
import '../widgets/widget.dart';
import '../Theme/app_styles.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
	final String title;
	const GlobalAppBar({super.key, required this.title});

	@override
	Widget build(BuildContext context) {
		return Container(
			decoration: BoxDecoration(
				color: AppColors.darkBackground,
				border: Border(
					bottom: BorderSide(
						color: Colors.white.withOpacity(0.1),
						width: 1.0,
					),
				),
			),
			child: AppBar(
				title: CustomPrimaryText(text: title),
				backgroundColor: Colors.transparent,
				elevation: 0,
				scrolledUnderElevation: 0,
				surfaceTintColor: Colors.transparent,
			),
		);
	}

	@override
	Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
