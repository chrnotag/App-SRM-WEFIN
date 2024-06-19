import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/carteira_aberto/carteira_aberto_provider.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/utils/money_format.dart';
import '../utils/dados_grafico_model.dart';
import '../widgets/legenda_grafico_widget.dart';

class GraficoCarteiraAberto extends StatefulWidget {
  const GraficoCarteiraAberto({super.key});

  @override
  State<GraficoCarteiraAberto> createState() => _GraficoCarteiraAbertoState();
}

class _GraficoCarteiraAbertoState extends State<GraficoCarteiraAberto> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Modular.get<CarteiraAbertoProvider>().carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    final carteiraAbertoProvider = context.watch<CarteiraAbertoProvider>();
    final List<DadosGraficoModel> filteredItems =
        carteiraAbertoProvider.dadosGrafico;
    final int itemCount = filteredItems.length;
    final double itemHeight = 88.h;
    final double listViewHeight = itemHeight * itemCount;

    String totalOperado() {
      double total = 0;
      for (var dados in filteredItems) {
        total += dados.valor;
      }
      return FormatarDinheiro.BR(total);
    }

    return FutureBuilder(
      future: carteiraAbertoProvider.futureGrafico,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 300.h,
            child: const Loader(),
          );
        }
        if (snapshot.hasError || snapshot.data!.error != null) {
          SizedBox(
            height: 300.h,
            child: Center(
              child: Text(
                'Erro ao obter dados do gráfico, tente novamente mais tarde!',
                style: context.textTheme.displaySmall!.copyWith(
                    color: context.labelTextColor),),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
            ],
          ),
        );

      },
    );
  }
}
