import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  final ValueChanged<DateTime>? onChanged;
  final DateTime? initialDate;
  final String? labelText;
  final String? hintText;

  const DateInput({
    Key? key,
    this.onChanged,
    this.initialDate,
    this.labelText,
    this.hintText,
  }) : super(key: key);

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  late TextEditingController _controller;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _controller = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(_selectedDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: null,
        contentPadding: EdgeInsets.only(top: -5.0),
        labelStyle: TextStyle(fontSize: 21.0, fontWeight: FontWeight.normal),
      ),
      onTap: _pickDate,
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
      });
      if (widget.onChanged != null) {
        widget.onChanged!(_selectedDate);
      }
    }
  }
}
