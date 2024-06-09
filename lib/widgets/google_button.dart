import 'package:flutter/material.dart';
import 'package:trab/themes/colors.dart';

class GoogleButton extends StatelessWidget {
  final String label;
  final Color textColor;
  final double fontSize;
  final VoidCallback onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const GoogleButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textColor = AppColors.whiteColor,
    this.fontSize = 19.0,
    this.borderRadius = 6.0,
    this.padding = const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 24.0),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Container(
        margin: const EdgeInsets.only(right: 5.0),
        child: Image.asset(
          'assets/icons/google_logo.png',
          height: 24.0,
        ),
      ),
      label: Text(
        label.toString(),
        style: TextStyle(
            color: textColor, fontSize: fontSize, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
      ),
    );
  }
}
