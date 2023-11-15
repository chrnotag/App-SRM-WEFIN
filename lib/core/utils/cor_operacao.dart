import 'dart:ui';

import '../../models/assinaturas_model/assinaturas_model.dart';
import '../constants/themes/theme_configs.dart';

class CorOperacao {
  static Color definirCorAssinante(Assinante assinatura) {
    List<String> todosOsStatus = assinatura.informacoesAssinante
        .map((info) => info.statusAssinatura.toUpperCase())
        .toList();

    const statusBotaoEnvio = ["EM DIGITAÇÃO", "ENVIADA"];
    const statusLaranja = [
      "EM ANÁLISE",
      "AUTORIZADA",
      "AGUARDANDO ASSINATURA",
      "ASSINADO",
      "PENDENTE"
    ];
    const statusSuccess = ["PAGAMENTO ENVIADO", "COBRANÇA"];

    if (todosOsStatus.any((status) => statusBotaoEnvio.contains(status))) {
      return AppColors.botaoEnvio;
    } else if (todosOsStatus.any((status) => statusLaranja.contains(status))) {
      return AppColors.laranja;
    } else if (todosOsStatus.any((status) => statusSuccess.contains(status))) {
      return AppColors.success;
    }

    return AppColors.error;
  }
  static Color definirCorOperacao(AssinaturasModel assinatura) {
    final status = assinatura.statusOperacao.toUpperCase();
    const statusAzul = ["EM DIGITAÇÃO", "ENVIADA"];
    const statusLaranja = [
      "EM ANÁLISE",
      "AUTORIZADA",
      "AGUARDANDO ASSINATURA",
      "ASSINADO",
      "PENDENTE"
    ];
    const statusVerde = ["PAGAMENTO ENVIADO", "COBRANÇA"];

    if (statusAzul.contains(status)) {
      return AppColors.botaoEnvio;
    } else if (statusLaranja.contains(status)) {
      return AppColors.laranja;
    } else if (statusVerde.contains(status)) {
      return AppColors.success;
    }
    return AppColors.error;
  }
}
