import 'package:flutter/material.dart';
import '../../../common/widgets/widget.dart';
import '../../../common/Theme/app_styles.dart';

typedef OnSaveDream = Future<void> Function(String dreamName);

class InputNameDialog extends StatefulWidget {
	final OnSaveDream onSave;

	const InputNameDialog({super.key, required this.onSave});

	@override
	State<InputNameDialog> createState() => _InputNameDialogState();
}

class _InputNameDialogState extends State<InputNameDialog> {
	final _formKey = GlobalKey<FormState>();
	final TextEditingController _dreamNameController = TextEditingController();
	bool _isSaving = false;

	@override
	void dispose() {
		_dreamNameController.dispose();
		super.dispose();
	}

	String? _validateDreamName(String? value) {
		if (value == null || value.trim().isEmpty) {
			return 'Please enter a dream name';
		}
		if (value.trim().length < 3) {
			return 'Dream name must be at least 3 characters';
		}
		return null;
	}

	Future<void> _handleSave() async {
		if (_formKey.currentState!.validate()) {
			setState(() => _isSaving = true);
			await widget.onSave(_dreamNameController.text.trim());
			setState(() => _isSaving = false);
			if (mounted) {
				_dreamNameController.clear();
				Navigator.of(context).pop();
			}
		}
	}

	@override
	Widget build(BuildContext context) {
		return Dialog(
			backgroundColor: Colors.transparent,
			child: Container(
				padding: EdgeInsets.all(24),
				decoration: BoxDecoration(
					color: AppColors.darkBackground,
					borderRadius: BorderRadius.circular(20),
					border: Border.all(
						color: AppColors.accentBlue.withOpacity(0.3),
						width: 1,
					),
				),
				child: Form(
					key: _formKey,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						mainAxisSize: MainAxisSize.min,
						children: [
							CustomPrimaryText(text: "Name Your Dream"),
							SizedBox(height: 6),
							CustomSecondaryText(text: "Give your dream a name"),
							SizedBox(height: 15),
							TextFormField(
								controller: _dreamNameController,
								validator: _validateDreamName,
								enabled: !_isSaving,
								decoration: InputDecoration(
									label: Text(
										"e.g., My Childhood dream",
										style: TextStyle(fontSize: 14),
									),
									contentPadding: const EdgeInsets.symmetric(
										vertical: 13,
										horizontal: 8,
									),
									border: OutlineInputBorder(
										borderRadius: BorderRadius.circular(10),
									),
								),
							),
							SizedBox(height: 15),
							Row(
								children: [
									Expanded(
										child: CustomizeButton(
											text: "Cancel",
											backgroundColor: AppColors.disabled,
											onPressed: _isSaving
													? null
													: () {
															_dreamNameController.clear();
															Navigator.of(context).pop();
														},
										),
									),
									SizedBox(width: 12),
									Expanded(
										child: CustomizeButton(
											text: _isSaving ? "Saving..." : "Save Dream",
											backgroundColor: AppColors.primaryBlue,
											onPressed: _isSaving ? null : _handleSave,
										),
									),
								],
							),
						],
					),
				),
			),
		);
	}
}


