import 'package:flutter/material.dart';
import 'package:trab/themes/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData leadingIcon;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.onLeadingPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: Text(
        title,
        style: const TextStyle(color: AppColors.whiteColor, fontSize: 18.0),
      ),
      leading: IconButton(
        icon: Icon(
          leadingIcon,
          color: Colors.white,
        ),
        onPressed: onLeadingPressed,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
