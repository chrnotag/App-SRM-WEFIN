import 'package:intl/intl.dart';

class FormatarData{
  static String formatar(String data){
    return data.substring(0,10);
  }
  static String formatarExtenso(DateTime data) {
    var diaDaSemana = DateFormat("EEEE, dd 'de' MMMM 'de' yyyy ", "pt-BR").format(data);


    diaDaSemana = diaDaSemana.replaceAll('-feira', '');

    return diaDaSemana;
  }
}