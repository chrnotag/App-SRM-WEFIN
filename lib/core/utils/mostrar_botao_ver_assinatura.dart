import 'package:flutter_modular/flutter_modular.dart';

import '../../models/monitor_operacoes_model/monitor_operacoes_model.dart';
import '../providers/monitor_assinatura_provider/assinatura_provider.dart';

class ExibirVerAssinatura {
  static bool isVisivel(MonitorOperacoesModel operacao) {
    if (operacao.statusOperacao.trim().toLowerCase() == 'aguardando assinatura' ||
        operacao.statusOperacao.trim().toLowerCase() == 'assinada') {
      return true;
    } else {
      return false;
    }
  }
}
