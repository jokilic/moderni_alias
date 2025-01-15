import 'package:flutter/services.dart';

class NumberInputFormatter extends TextInputFormatter {
  final int lowestNumber;
  final int highestNumber;
  final int textLength;

  NumberInputFormatter({
    required this.lowestNumber,
    required this.highestNumber,
    this.textLength = 2,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newTextLength = newValue.text.length;

    if (newTextLength >= textLength) {
      final newValueInt = int.parse(newValue.text);

      if (newValueInt < lowestNumber || newValueInt > highestNumber) {
        return oldValue;
      }
    }

    return newValue;
  }
}
