part of '../carteira_consolidada_screen.dart';

class _GraficoSituacaoGeral extends StatefulWidget {
  const _GraficoSituacaoGeral({super.key});

  @override
  State<_GraficoSituacaoGeral> createState() => _GraficoSituacaoGeralState();
}

class _GraficoSituacaoGeralState extends State<_GraficoSituacaoGeral> {
  @override
  Widget build(BuildContext context) {
    final geralCarteiraProvider = Modular.get<GeralCarteiraProvider>();
    final List<DadosGraficoModel> filteredItems = geralCarteiraProvider.dadosGraficoModel;
    final int itemCount = filteredItems.length;
    final int crossAxisCount = 2;
    final double itemHeight = 95.0;
    final double crossAxisSpacing = 8.0;
    final int rowCount = (itemCount / crossAxisCount).ceil();
    final double gridViewHeight = (itemHeight + crossAxisSpacing) * rowCount - crossAxisSpacing;

    String totalOperado(){
      double total = 0;
      for(var dados in filteredItems){
        total += dados.valor;
      }
      return FormatarDinheiro.BR(total);
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
                          Text('Total Operado', style: context.textTheme.bodyLarge),
                          SizedBox(height: 8.h,),
                          Text(totalOperado(), style: context.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w600, color: context.labelTextColor)),
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
            height: gridViewHeight, // Altura dinâmica do GridView
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(), // Desativa a rolagem
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: crossAxisSpacing,
                childAspectRatio: (375.w / crossAxisCount) /
                    itemHeight, // Garantir que a proporção esteja correta
              ),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                final e = filteredItems[index];
                return _LegendaGraficoWidget(
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
  }
}

