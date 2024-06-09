import 'package:flutter/material.dart';
import 'package:trab/themes/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  Color backgroundColor;
  Color textColor;
  VoidCallback onPressed;
  double borderRadius;
  double fontSize;
  EdgeInsetsGeometry padding;

  CustomButton({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    required this.onPressed,
    this.borderRadius = 6.0,
    this.fontSize = 18.0,
    this.padding = const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
      ),
    );
  }
}
