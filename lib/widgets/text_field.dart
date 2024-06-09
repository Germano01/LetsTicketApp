import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController? controller;
  bool obscureText;
  final double borderRadius;
  final double fontSize;
  final bool isPassword;
  final int maxLines;
  FormFieldValidator<String>? validator;

  CustomTextField({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.controller,
    this.obscureText = false,
    this.borderRadius = 8.0,
    this.fontSize = 16.0,
    this.isPassword = false,
    this.maxLines = 1,
    required this.validator,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          fontSize: widget.fontSize,
        ),
        suffixIcon: widget.isPassword ? buildPasswordIcon() : null,
      ),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      validator: widget.validator,
    );
  }

  Widget buildPasswordIcon() {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        icon:
            Icon(widget.obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            widget.obscureText = !widget.obscureText;
          });
        },
      ),
    );
  }
}
