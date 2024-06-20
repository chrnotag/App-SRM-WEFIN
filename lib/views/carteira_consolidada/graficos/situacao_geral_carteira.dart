import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/views/carteira_consolidada/graficos/grafico_carteira_aberto.dart';
import 'package:Srm_Asset/views/carteira_consolidada/graficos/grafico_liquidez.dart';
import 'package:Srm_Asset/views/carteira_consolidada/widgets/titulo_list_item.dart';
import 'package:Srm_Asset/views/carteira_consolidada/widgets/titulo_list_item_interno.dart';
import 'package:Srm_Asset/views/carteira_consolidada/widgets/titulo_list_item_interno.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/providers/carteira_consolidada_provider/geral_carteira/geral_carteira_provider.dart';
import '../utils/dados_grafico_model.dart';
import '../widgets/legenda_grafico_widget.dart';

class GraficoSituacaoGeral extends StatefulWidget {
  const GraficoSituacaoGeral({super.key});

  @override
  State<GraficoSituacaoGeral> createState() => _GraficoSituacaoGeralState();
}

class _GraficoSituacaoGeralState extends State<GraficoSituacaoGeral> {
  @override
  Widget build(BuildContext context) {
    final geralCarteiraProvider = Modular.get<GeralCarteiraProvider>();
    final List<DadosGraficoModel> filteredItems =
        geralCarteiraProvider.dadosGraficoModel;
    final int itemCount = filteredItems.length;
    final double itemHeight = 100.h;
    final double listViewHeight = itemHeight * itemCount;

    String totalOperado() {
      double total = 0;
      for (var dados in filteredItems) {
        total += dados.valor;
      }
      return total.toBRL;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 16.h, bottom: 25.h),
              child: SizedBox(
                  width: 300.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Situação Geral da Carteira',
                        style: context.textTheme.displaySmall!.copyWith(
                            color: context.labelTextColor,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'Situação dos títulos totalmente operados',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.labelTextColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25.h, top: 8.h),
            child: Center(
              child: SizedBox(
                height: 270.h,
                width: 270.w,
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        sections: filteredItems
                            .map((e) => PieChartSectionData(
                                color: e.cor,
                                value: e.valor,
                                showTitle: false,
                                radius: 16))
                            .toList(),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Total Operado',
                              style: context.textTheme.bodyLarge),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(totalOperado(),
                              style: context.textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.labelTextColor)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 375.w,
            height: listViewHeight, // Altura dinâmica do GridView
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(), // Desativa a rolagem
              itemCount: itemCount,
              itemBuilder: (context, index) {
                final e = filteredItems[index];
                return LegendaGraficoWidget(
                  corLegenda: e.cor,
                  titulo: e.titulo,
                  porcentagem: e.porcentagem,
                  valor: e.valor,
                  qtdTitulos: e.qtdTitulos,
                );
              },
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Column(
            children: [
              Divider(),
              TituloListItemInterno(
                  label: 'Situação da carteira em aberto',
                  widgetExpansivel: GraficoCarteiraAberto()),
            ],
          ),
          Column(
            children: [
              Divider(),
              TituloListItemInterno(
                  label: 'Prazo de liquidez',
                  widgetExpansivel: GraficoLiquidez()),
            ],
          ),
        ],
      ),
    );
  }
}
