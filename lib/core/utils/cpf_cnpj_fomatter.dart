import 'package:flutter/services.dart';

class CpfCnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (text.length > 14) {
      text = text.substring(0, 14);
    }

    String formattedText;
    if (text.length <= 11) {
      formattedText = _applyCpfMask(text);
    } else {
      formattedText = _applyCnpjMask(text);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _applyCpfMask(String text) {
    StringBuffer buffer = StringBuffer();
    int length = text.length;

    for (int i = 0; i < length; i++) {
      if (i == 3 || i == 6) {
        buffer.write('.');
      } else if (i == 9) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    return buffer.toString();
  }

  String _applyCnpjMask(String text) {
    StringBuffer buffer = StringBuffer();
    int length = text.length;

    for (int i = 0; i < length; i++) {
      if (i == 2 || i == 5) {
        buffer.write('.');
      } else if (i == 8) {
        buffer.write('/');
      } else if (i == 12) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    return buffer.toString();
  }
}
