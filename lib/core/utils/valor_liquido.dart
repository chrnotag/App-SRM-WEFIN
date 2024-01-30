import 'package:modular_study/core/utils/money_format.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

import '../../models/monitor_operacoes_model/monitor_operacoes_model.dart';

class ValorLiquido {
  static String regraExibirValorLiquido(
      {required String statusOperacao, required double valor}) {
    List<String> status = [
      'aguardando assinatura',
      'assinada',
      'pagamento enviado',
      'cobrança'
    ];
    if (status.contains(statusOperacao)) {
      return FormatarDinheiro.BR(valor);
    }
    else {
      return "---";
    }
  }
}
