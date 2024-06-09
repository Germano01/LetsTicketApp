import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trab/bloc/event_ticket_bloc.dart';
import 'package:trab/models/event_ticket_model.dart';
import 'package:trab/provider/rest_provider.dart';
import 'package:trab/view/edit_ticket_screen.dart';
import 'package:trab/widgets/custom_app_bar.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventTicketBloc(
          Provider.of<EventTicketRestProvider>(context, listen: false))
        ..add(GetAllEventTickets()),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Meus Ingressos de Evento',
          leadingIcon: Icons.arrow_back,
          onLeadingPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body:
            const TicketsList(), // Extrai a lista de ingressos para um widget separado
      ),
    );
  }
}

class TicketsList extends StatelessWidget {
  const TicketsList({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventTicketBloc, EventTicketState>(
      builder: (context, state) {
        if (state is EventTicketLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EventTicketLoadSuccess) {
          if (state.ticketList.isEmpty) {
            return const Center(
              child: Text(
                'Você ainda não divulgou ingressos de eventos.',
                style: TextStyle(fontSize: 16.0),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.ticketList.length,
              itemBuilder: (context, index) {
                final ticket = state.ticketList[index];
                return TicketCard(
                  ticket: ticket,
                );
              },
            );
          }
        } else if (state is EventTicketLoadFailure) {
          return Center(child: Text('Erro: ${state.error}'));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class TicketCard extends StatelessWidget {
  final EventTicketModel ticket;

  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventTicketBloc, EventTicketState>(
      listener: (context, state) {
        if (state is EventTicketOperationSuccess) {
          // Atualizar a lista de tickets após a exclusão
          BlocProvider.of<EventTicketBloc>(context).add(GetAllEventTickets());
        }
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ticket.eventName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(
                    'x${ticket.availableTickets}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                ticket.eventDescription,
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Data do Evento: ${DateFormat('dd/MM/yyyy').format(ticket.eventDate)}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    'Valor Total: ${ticket.ticketValue * ticket.availableTickets}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<EventTicketBloc>(context).add(
                          DeleteEventTicket(
                              ticketId: ticket
                                  .id!)); // Passa o ID do ticket para a ação de exclusão
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                  IconButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditTicketScreen(ticket: ticket),
                        ),
                      );

                      // Verificar se a edição foi bem-sucedida
                      if (result == true) {
                        // Atualizar os ingressos após uma edição bem-sucedida
                        BlocProvider.of<EventTicketBloc>(context)
                            .add(GetAllEventTickets());
                      }
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
