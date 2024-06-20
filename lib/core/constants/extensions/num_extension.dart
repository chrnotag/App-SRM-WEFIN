import 'package:intl/intl.dart';

extension NumExtension on num {
  String get toPercent =>
      ('${toStringAsFixed(2).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '')}%');

  String get toBRL =>
      NumberFormat.currency(locale: 'pt-BR', symbol: 'R\$', decimalDigits: 2)
          .format(this);
}
