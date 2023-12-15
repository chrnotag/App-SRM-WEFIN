import 'package:intl/intl.dart';

class FormatarDinheiro {
  static String BR(double money) {
    return NumberFormat.currency(
            locale: 'pt-BR', symbol: 'R\$', decimalDigits: 2)
        .format(money);
  }
}
