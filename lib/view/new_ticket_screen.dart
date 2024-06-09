import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trab/bloc/event_ticket_bloc.dart';
import 'package:trab/provider/rest_provider.dart';
import 'package:trab/utils/utils.dart';
import 'package:trab/widgets/button.dart';
import 'package:trab/widgets/currency_input.dart';
import 'package:trab/widgets/custom_app_bar.dart';
import 'package:trab/widgets/data_input.dart';
import 'package:trab/widgets/image_input.dart';
import 'package:trab/widgets/text_field.dart';

import '../models/event_ticket_model.dart';

class NewTicketScreen extends StatefulWidget {
  const NewTicketScreen({Key? key}) : super(key: key);

  @override
  State<NewTicketScreen> createState() => _NewTicketScreenState();
}

class _NewTicketScreenState extends State<NewTicketScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nomeDoEventoController = TextEditingController();
  final TextEditingController descricaoDoEventoController =
      TextEditingController();
  final TextEditingController valorDoIngressoController =
      TextEditingController();
  final TextEditingController dateDoEventoController = TextEditingController();
  final TextEditingController imagemDoEventoController =
      TextEditingController();
  final TextEditingController quantidadeDeIngressosController =
      TextEditingController();
  DateTime? dataDoEvento = DateTime.now();

  late NumberFormat _currencyFormat;

  @override
  void initState() {
    super.initState();
    _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    valorDoIngressoController.text = _currencyFormat.format(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Novo Ingresso de Evento',
        leadingIcon: Icons.arrow_back,
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 22.0, left: 15.0, right: 15.0),
        child: Form(
          key: _formKey,
          child: BlocProvider(
            create: (context) => EventTicketBloc(
              Provider.of<EventTicketRestProvider>(context, listen: false),
            ),
            child: Column(
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
                  initialDate: DateTime.now(),
                  onChanged: (DateTime date) {
                    setState(() {
                      dataDoEvento = date;
                    });
                  },
                ),
                const SizedBox(height: 32.0),
                CurrencyInput(
                  controller: valorDoIngressoController,
                  initialValue: 0.0,
                  onChanged: (value) {},
                  labelText: 'Valor do ingresso',
                  hintText: 'Informe o valor do ingresso',
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
                BlocBuilder<EventTicketBloc, EventTicketState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                        label: 'Criar Ingresso',
                        fontSize: 18.0,
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final eventTicket = EventTicketModel(
                              eventName: nomeDoEventoController.text,
                              eventDescription:
                                  descricaoDoEventoController.text,
                              eventDate: dataDoEvento!,
                              ticketValue: convertCurrencyToDouble(
                                  valorDoIngressoController.text),
                              availableTickets: int.parse(
                                  quantidadeDeIngressosController.text),
                              eventImage: imagemDoEventoController.text,
                            );

                            final provider =
                                Provider.of<EventTicketRestProvider>(
                              context,
                              listen: false,
                            );
                            await provider.createEventTicket(eventTicket);

                            // Atualize os ingressos após a adição do ticket
                            Provider.of<EventTicketRestProvider>(context,
                                    listen: false)
                                .getAllEventTickets();

                            Navigator.of(context).pop(true);
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
