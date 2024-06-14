import '../../models/carteira_consolidada/geral_carteira/geral_carteira_model.dart';
class CalcularPorcentagemGraficos {
  static String calcular(double valor, GeralCarteiraModel dadosCarteira) {
    int valorTotal = 0;
    valorTotal = dadosCarteira.valorTotalRecebiveisVencidos +
        dadosCarteira.valorTotalRecebiveisLiquidados +
        dadosCarteira.valorTotalRecebiveisEmAberto +
        dadosCarteira.valorTotalRecebiveisAVencer;

    double porcentagem = (valor / valorTotal) * 100;

    // Converte a porcentagem para String e remove zeros desnecessários
    String porcentagemStr = porcentagem.toStringAsFixed(2).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');

    return '$porcentagemStr%';
  }
}

