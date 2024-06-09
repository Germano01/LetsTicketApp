import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:trab/bloc/event_ticket_bloc.dart';
import 'package:trab/models/event_ticket_model.dart';
import 'package:trab/provider/rest_provider.dart';
import 'package:trab/widgets/event_card.dart';

class EventSlider extends StatelessWidget {
  const EventSlider({super.key, required List<EventTicketModel> tickets});

  @override
  Widget build(BuildContext context) {
    final eventTicketRestProvider =
        Provider.of<EventTicketRestProvider>(context);

    return BlocProvider(
      create: (context) =>
          EventTicketBloc(eventTicketRestProvider)..add(GetAllEventTickets()),
      child: BlocBuilder<EventTicketBloc, EventTicketState>(
        builder: (context, state) {
          if (state is EventTicketLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventTicketLoadSuccess) {
            final events = state.ticketList;

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              child: SizedBox(
                height: 250.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return EventCard(
                      title: event.eventName,
                      imageUrl: event.eventImage.isNotEmpty
                          ? event.eventImage
                          : 'assets/img/default_event.png', // Default image if none provided
                    );
                  },
                ),
              ),
            );
          } else if (state is EventTicketLoadFailure) {
            return Center(child: Text('Failed to load events: ${state.error}'));
          } else {
            return const Center(child: Text('No events available'));
          }
        },
      ),
    );
  }
}
