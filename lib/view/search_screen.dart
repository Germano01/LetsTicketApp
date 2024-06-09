import 'package:flutter/material.dart';
import 'package:trab/utils/utils.dart';
import 'package:trab/view/home_screen.dart';
import 'package:trab/view/my_tickets_screen.dart';
import 'package:trab/widgets/bottom_navigation_bar.dart';
import 'package:trab/widgets/header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            navigateToScreen(context, HomeScreen());
          } else if (index == 2) {
            navigateToScreen(context, MyTicketsScreen());
          }
        },
      ),
    );
  }
}
