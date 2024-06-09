import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trab/bloc/event_ticket_bloc.dart';
import 'package:trab/models/event_ticket_model.dart';
import 'package:trab/provider/rest_provider.dart';
import 'package:trab/utils/utils.dart';
import 'package:trab/widgets/button.dart';
import 'package:trab/widgets/custom_app_bar.dart';
import 'package:trab/widgets/data_input.dart';
import 'package:trab/widgets/image_input.dart';
import 'package:trab/widgets/text_field.dart';
import 'package:intl/intl.dart';

class EditTicketScreen extends StatefulWidget {
  final EventTicketModel ticket;

  const EditTicketScreen({Key? key, required this.ticket});

  @override
  State<EditTicketScreen> createState() => _EditTicketScreenState();
}

class _EditTicketScreenState extends State<EditTicketScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nomeDoEventoController = TextEditingController();
  final TextEditingController descricaoDoEventoController =
      TextEditingController();
  final TextEditingController valorDoIngressoController =
      TextEditingController();
  final TextEditingController imagemDoEventoController =
      TextEditingController();
  final TextEditingController quantidadeDeIngressosController =
      TextEditingController();
  late DateTime dataDoEvento;
  late NumberFormat _currencyFormat;

  @override
  void initState() {
    super.initState();
    _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    dataDoEvento = widget.ticket.eventDate;
    nomeDoEventoController.text = widget.ticket.eventName;
    descricaoDoEventoController.text = widget.ticket.eventDescription;
    valorDoIngressoController.text =
        _currencyFormat.format(widget.ticket.ticketValue);
    quantidadeDeIngressosController.text =
        widget.ticket.availableTickets.toString();
    imagemDoEventoController.text = widget.ticket.eventImage;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventTicketBloc(
          Provider.of<EventTicketRestProvider>(context, listen: false)),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Editar Ingresso de Evento',
          leadingIcon: Icons.arrow_back,
          onLeadingPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 22.0, left: 15.0, right: 15.0),
          child: Form(
            key: _formKey,
            child: BlocConsumer<EventTicketBloc, EventTicketState>(
              listener: (context, state) {
                if (state is EventTicketOperationFailure) {
                  print('Erro ao atualizar o ingresso: ${state.error}');
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32.0),
                    CustomTextField(
                      label: "Nome do Evento",
                      controller: nomeDoEventoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome do evento';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32.0),
                    CustomTextField(
                      label: "Descrição do Evento",
                      controller: descricaoDoEventoController,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma descrição para o evento';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32.0),
                    DateInput(
                      labelText: 'Data do Evento',
                      hintText: 'DD/MM/AAAA',
                      initialDate: dataDoEvento,
                      onChanged: (DateTime date) {
                        setState(() {
                          dataDoEvento = date;
                        });
                      },
                    ),
                    const SizedBox(height: 32.0),
                    CustomTextField(
                      label: "Valor do Ingresso",
                      controller: valorDoIngressoController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o valor do ingresso';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32.0),
                    CustomTextField(
                      label: "Quantidade de Ingressos",
                      controller: quantidadeDeIngressosController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a quantidade de ingressos disponíveis';
                        }
                        if (int.parse(value) == 0) {
                          return 'Você deve ofertar pelo menos 1 ingresso';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32.0),
                    ImageInput(
                      imageController: imagemDoEventoController,
                    ),
                    const SizedBox(height: 32.0),
                    if (state is EventTicketLoading)
                      const Center(child: CircularProgressIndicator()),
                    if (state is! EventTicketLoading)
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomButton(
                          label: 'Salvar Alterações',
                          fontSize: 18.0,
                          padding:
                              const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final eventTicket = EventTicketModel(
                                id: widget.ticket.id,
                                eventName: nomeDoEventoController.text,
                                eventDescription:
                                    descricaoDoEventoController.text,
                                eventDate: dataDoEvento,
                                ticketValue: convertCurrencyToDouble(
                                    valorDoIngressoController.text),
                                availableTickets: int.parse(
                                    quantidadeDeIngressosController.text),
                                eventImage: imagemDoEventoController.text,
                              );

                              await BlocProvider.of<EventTicketBloc>(context)
                                  .addEventTicket(
                                      UpdateEventTicket(ticket: eventTicket));

                              Navigator.of(context).pop(true);
                            }
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
