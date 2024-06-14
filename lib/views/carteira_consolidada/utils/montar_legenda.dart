part of '../carteira_consolidada_screen.dart';

class MontarLegenda {
  static List<_LegendaGraficoWidget> montar(List<DadosGraficoModel> dados) {
    return dados
        .map((e) => _LegendaGraficoWidget(
            corLegenda: e.cor,
            titulo: e.titulo,
            porcentagem: e.porcentagem,
            valor: e.valor,
            qtdTitulos: e.qtdTitulos))
        .toList();
  }
}
