import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/views/carteira_consolidada/graficos/grafico_recebiveis.dart';
import 'package:Srm_Asset/views/carteira_consolidada/widgets/titulo_list_item.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/geral_carteira/geral_carteira_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'graficos/situacao_geral_carteira.dart';

class CarteiraConsolidadaScreen extends StatefulWidget {
  const CarteiraConsolidadaScreen({super.key});

  @override
  State<CarteiraConsolidadaScreen> createState() =>
      _CarteiraConsolidadaScreenState();
}

class _CarteiraConsolidadaScreenState extends State<CarteiraConsolidadaScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Modular.get<GeralCarteiraProvider>();
    provider.carregarDados();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Modular.get<GeralCarteiraProvider>().limparDados();
  }

  @override
  Widget build(BuildContext context) {
    GeralCarteiraProvider carteiraProvider =
        context.watch<GeralCarteiraProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carteira Consolidada',
          style: context.textTheme.displaySmall!.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: carteiraProvider.futureGrafico,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }
          if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) => AlertDialogGenerico(
                    title: 'Erro ao carregar dados',
                    msg: 'Erro ao carregar dados da carteira ${snapshot.error}',
                    onPressed: () {
                      Modular.to.pop();
                      Modular.to.pop();
                    }),
              );
            });
          }

          if (snapshot.data!.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) => AlertDialogGenerico(
                    title: 'Erro ao obter dados',
                    msg:
                        'Erro ao obter dados da carteira, tente novamente mais tarde.',
                    onPressed: () {
                      Modular.to.pop();
                      Modular.to.pop();
                    }),
              );
            });
          }

          return const SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  TituloListItem(
                      label: 'Distribuição de Recebíveis',
                      widgetExpansivel: GraficoRecebiveis(),
                  expandir: true,),
                  TituloListItem(
                    label: 'Situação Carteira',
                    widgetExpansivel: GraficoSituacaoGeral(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
