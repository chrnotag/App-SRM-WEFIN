import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';

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
      return valor.toBRL;
    }
    else {
      return "---";
    }
  }
}
