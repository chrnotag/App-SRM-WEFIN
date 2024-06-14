import 'package:fl_chart/fl_chart.dart';

import 'dados_grafico_model.dart';

class MontarGrafico {
  static List<PieChartSectionData> montarSecoes(List<DadosGraficoModel> dados) {
    return dados
        .map((e) => PieChartSectionData(
            color: e.cor, title: e.titulo, value: e.valor, showTitle: false))
        .toList();
  }
}
