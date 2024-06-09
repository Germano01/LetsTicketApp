import 'package:flutter/material.dart';
import 'package:trab/utils/utils.dart';
import 'package:trab/view/home_screen.dart';
import 'package:trab/view/search_screen.dart';
import 'package:trab/widgets/bottom_navigation_bar.dart';
import 'package:trab/widgets/header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomHeader(
            userName: 'Victor Osses',
            onSupportPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            navigateToScreen(context, HomeScreen());
          } else if (index == 1) {
            navigateToScreen(context, SearchScreen());
          }
        },
      ),
    );
  }
}
