
import 'package:flutter/material.dart';
import '../../../common/Theme/app_styles.dart';

class DreamAppBar extends StatelessWidget implements PreferredSizeWidget {
	final String? title;
	final TextStyle? titleStyle;
	final VoidCallback? onCompare;

	const DreamAppBar({
		super.key,
		this.title,
		this.titleStyle,
		this.onCompare,
	});

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
				title: Text(
					title ?? 'Dream Details',
					style: titleStyle,
				),
				actions: [
					Padding(
						padding: const EdgeInsets.only(right: 8.0),
						child: IconButton(
							icon: const Icon(Icons.filter_list),
							tooltip: 'Compare',
							onPressed: onCompare,
						),
					),
				],
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
