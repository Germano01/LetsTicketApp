import 'package:flutter/material.dart';
import 'package:trab/themes/colors.dart';
import 'package:trab/view/new_ticket_screen.dart';

class TicketButton extends StatelessWidget {
  const TicketButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewTicketScreen()),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 42));
  }
}
