import 'package:flutter/material.dart';
import 'package:trab/themes/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.primaryColor,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor.withOpacity(0.5),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Pesquisar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.airplane_ticket),
          label: 'Ingressos',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
