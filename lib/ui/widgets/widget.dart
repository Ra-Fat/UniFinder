import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomizeButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final IconData? icon;
  final bool isTextButton;
  const CustomizeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isTextButton = false,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 16,
    this.height = 50,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (isTextButton) {
      return SizedBox(
        width: double.infinity,
        height: height,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            alignment: Alignment.center,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: textColor ?? AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryBlue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor ?? AppColors.textPrimary),
              SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: textColor ?? AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CustomSecondaryText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;

  const CustomSecondaryText({
    super.key,
    required this.text,
    this.fontSize = 13,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor ?? AppColors.textSecondary
      ),
    );
  }
}


class CustomPrimaryText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;

  const CustomPrimaryText({super.key,
    required this.text,
    this.fontSize = 20,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor ?? AppColors.textPrimary
      ),
    );
  }
}