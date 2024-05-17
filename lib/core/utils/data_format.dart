import 'package:intl/intl.dart';

class FormatarData{
  static String formatar(String data){
    return data.substring(0,10);
  }
  static String formatarExtenso(DateTime data) {
    var diaDaSemana = DateFormat('EEEE', 'pt_BR').format(data);
    var dia = DateFormat('dd', 'pt_BR').format(data);
    var mes = DateFormat('MMMM', 'pt_BR').format(data);
    var ano = DateFormat('yyyy', 'pt_BR').format(data);

    diaDaSemana = diaDaSemana.replaceAll('-feira', '');

    return '$diaDaSemana, $dia de $mes de $ano';
  }
}