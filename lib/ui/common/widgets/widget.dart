import 'package:flutter/material.dart';
import '../Theme/app_styles.dart';

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
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
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
    this.borderRadius = 15,
    this.borderColor,
    this.borderWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (isTextButton) {
      return SizedBox(
        width: double.infinity,
        height: height,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(alignment: Alignment.center),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            side: borderWidth != null && borderWidth! > 0
                ? BorderSide(
                    color: borderColor ?? AppColors.textPrimary,
                    width: 1,
                  )
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  color: textColor ?? AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 10),
            if (icon != null) ...[
              Icon(icon, color: textColor ?? AppColors.textPrimary),
              SizedBox(width: 8),
            ],
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
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor ?? AppColors.textSecondary,
      ),
    );
  }
}

class CustomPrimaryText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;

  const CustomPrimaryText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: textColor ?? AppColors.textPrimary,
      ),
    );
  }
}
