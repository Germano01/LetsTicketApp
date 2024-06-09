import 'package:flutter/material.dart';

void navigateToScreen(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

double convertCurrencyToDouble(String currencyText) {
  String valueWithoutSymbol = currencyText.replaceAll(RegExp(r'[^\d\,]'), '');
  String valueWithDot = valueWithoutSymbol.replaceAll(',', '.');
  double value = double.parse(valueWithDot);
  return value;
}
