import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trab/provider/rest_provider.dart';
import 'package:trab/utils/utils.dart';
import 'package:trab/view/my_tickets_screen.dart';
import 'package:trab/view/search_screen.dart';
import 'package:trab/widgets/bottom_navigation_bar.dart';
import 'package:trab/widgets/event_slider.dart';
import 'package:trab/widgets/header.dart';
import 'package:trab/widgets/ticket_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _updateTickets();
  }

  void _updateTickets() async {
    await Provider.of<EventTicketRestProvider>(context, listen: false)
        .getAllEventTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomHeader(
            userName: 'Victor Osses',
            onSupportPressed: () {},
          ),
          Consumer<EventTicketRestProvider>(
            builder: (context, provider, child) {
              final tickets = provider.tickets;

              if (tickets.isEmpty) {
                return const Center(child: Text('Nenhum ingresso disponível.'));
              }

              return EventSlider(tickets: tickets);
            },
          ),
          const Expanded(
            child: Stack(
              children: [
                Positioned(
                  bottom: 24,
                  right: 24,
                  child: SizedBox(
                    height: 72,
                    width: 72,
                    child: TicketButton(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            navigateToScreen(context, const SearchScreen());
          } else if (index == 2) {
            navigateToScreen(context, const MyTicketsScreen());
          }
        },
      ),
    );
  }
}
