import 'package:intl/intl.dart';

class FormatarData {
  static String formatar(String data) {
    return data.substring(0, 10);
  }

  static String formatarPtBR(String data) {
    final date = DateTime.parse(data);
    final dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(date);
  }

  static String formatarExtenso(DateTime data) {
    var diaDaSemana =
        DateFormat("EEEE, dd 'de' MMMM 'de' yyyy ", "pt-BR").format(data);

    diaDaSemana = diaDaSemana.replaceAll('-feira', '');

    return diaDaSemana;
  }
}
