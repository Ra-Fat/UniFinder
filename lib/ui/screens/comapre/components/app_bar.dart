import 'package:flutter/material.dart';
import '../../../theme/app_styles.dart';
import '../../../common/widgets/widget.dart';

class CompareAppBar extends StatelessWidget implements PreferredSizeWidget {
	const CompareAppBar({Key? key}) : super(key: key);

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
				title: CustomPrimaryText(text: 'Compare Universities'),
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
