import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/recebiveis/recebiveis_download.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/recebiveis/recebiveis_provider.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/core/utils/pdf_manager.dart';
import 'package:Srm_Asset/views/carteira_consolidada/utils/dados_grafico_model.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../widgets/loader_widget.dart';
import '../widgets/legenda_recebiveis.dart';

class GraficoRecebiveis extends StatefulWidget {
  const GraficoRecebiveis({super.key});

  @override
  State<GraficoRecebiveis> createState() => _GraficoRecebiveisState();
}

class _GraficoRecebiveisState extends State<GraficoRecebiveis> {
  @override
  Widget build(BuildContext context) {
    final recebiveisProvider = context.watch<RecebiveisProvider>();
    final List<DadosGraficoModel> filteredItems =
        recebiveisProvider.dadosGrafico();
    final int itemCount = filteredItems.length;
    final double itemHeight = 50.h;
    final double listViewHeight = itemHeight * 4;

    String totalOperado() {
      double total = 0;
      for (var dados in filteredItems) {
        total += dados.valor ?? 0;
      }
      return total.toBRL;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                        sections: filteredItems.map((e) {
                          // Verifica se todos os valores são zero
                          bool todosValoresZero = filteredItems.every(
                              (item) => item.valor == null || item.valor == 0);

                          return PieChartSectionData(
                            color: todosValoresZero ? Colors.grey : e.cor,
                            value: todosValoresZero ? 100 : e.valor,
                            showTitle: false,
                            radius: 16,
                          );
                        }).toList(),
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
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: SizedBox(
              height: listViewHeight,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      1.9, // Ajuste este valor conforme necessário
                ),
                physics: NeverScrollableScrollPhysics(),
                // Desativa a rolagem
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  final e = filteredItems[index];
                  return LegendaGraficoRecebiveisWidget(
                    corLegenda: e.cor,
                    titulo: e.titulo.toUpperCase(),
                    porcentagem: e.porcentagem,
                    valor: e.valor,
                  );
                },
              ),
            ),
          ),
          if (recebiveisProvider.pdfRecebiveis != null)
            Padding(
              padding: EdgeInsets.all(16.r),
              child: BotaoPadrao(
                  label: 'Baixar Distribuição de Recebíveis',
                  onPressed: () async {
                    OverlayApp.iniciaOverlay(context);
                    await DownloadRecebiveisImpl.baixar();
                    OverlayApp.terminaOverlay();
                    PDFUtils.sharePDF(
                        recebiveisProvider.pdfRecebiveis, 'Recebíveis');
                  }),
            ),
        ],
      ),
    );
  }
}
