import 'package:flutter_modular/flutter_modular.dart';

import '../../models/monitor_operacoes_model/monitor_operacoes_model.dart';
import '../providers/monitor_assinatura_provider/assinatura_provider.dart';

class ExibirVerAssinatura {
  static bool isVisivel(MonitorOperacoesModel operacao) {
    AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
    final mapaAssinaturas = assinaturaProvider.assinaturasMapeadas;
    if (mapaAssinaturas.containsKey(operacao.codigoOperacao)) {
      var assinatura = mapaAssinaturas[operacao.codigoOperacao];
      if ((operacao.statusOperacao.trim() == 'Aguardando Assinatura' ||
              operacao.statusOperacao.trim() == 'Assinada') &&
          (assinatura?.statusAssinaturaDigital == 'Assinada' ||
              assinatura?.statusAssinaturaDigital == 'Aguardando Assinatura')) {
        return true;
      }
    }
    return false;
  }
}
