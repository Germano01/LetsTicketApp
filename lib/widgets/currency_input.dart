import 'package:flutter/material.dart';

class CurrencyInput extends StatefulWidget {
  final double? initialValue;
  final ValueChanged<double>? onChanged;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;

  const CurrencyInput({
    super.key,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.labelText,
    this.hintText,
  });

  @override
  _CurrencyInputState createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe o valor do ingresso';
        }
        double? parsedValue = double.tryParse(value
            .replaceAll(',', '.')
            .replaceAll('R', '')
            .replaceAll('\$', '')
            .trim());
        if (parsedValue == null || parsedValue <= 0) {
          return 'O valor do ingresso deve ser maior R\$ 0,00';
        }
        return null;
      },
      onChanged: (value) {
        if (widget.onChanged != null) {
          double? parsedValue = double.tryParse(value.replaceAll(',', '.'));
          if (parsedValue != null) {
            widget.onChanged!(parsedValue);
          }
        }
      },
    );
  }
}
