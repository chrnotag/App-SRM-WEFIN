import 'dart:ffi';
import 'dart:math';

import 'package:Srm_Asset/core/constants/enuns/tipo_operacao_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/constants/tema_configs.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_impl.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_provider.dart';
import 'package:Srm_Asset/core/utils/data_format.dart';
import 'package:Srm_Asset/core/utils/money_format.dart';
import 'package:Srm_Asset/generated/assets.dart';
import 'package:Srm_Asset/models/conta_digital/extrato/conta_extrato_model.dart';
import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:Srm_Asset/views/conta_digital/widgets/app_bar_conta_digital.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:Srm_Asset/widgets/pdfview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../core/implementations_config/api_response.dart';
import '../../../core/providers/conta_digital/tabbar_meses_provider.dart';
import '../../../core/utils/ultimo_dia_mes.dart';

part 'widgets/item_lista_extrato.dart';

part 'widgets/item_lista_operacao.dart';

part 'widgets/tabbar_meses.dart';

part 'widgets/menu_filtro.dart';

part 'widgets/item_menu_filtro.dart';

class TelaExtrato extends StatefulWidget {
  const TelaExtrato({super.key});

  @override
  State<TelaExtrato> createState() => _TelaExtratoState();
}

int tamanhoLista = 7;

class _TelaExtratoState extends State<TelaExtrato>
    with TickerProviderStateMixin {
  TabController? _tabController;
  final contaDigitalProvider = Modular.get<ContaDigitalProvider>();
  final extratoProviderInit = Modular.get<ExtratoProvider>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2);
    extratoProviderInit.carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    final extratoProvider = context.watch<ExtratoProvider>();
    List<Widget> buildOperacoes(int index) {
      List<Widget> lista = [];
      print('tamanho lista: ${extratoProvider.itensExtrato.length}\nindex: $index');
      List<Lancamento> lancamentos = extratoProvider.itensExtrato[index].lancamentos;
        for (var lancamento in lancamentos) {
          lista.add(_ItemListaOperacao(
              tipoTED: lancamento.evento.codigo.tipoTed,
              descricao: lancamento.evento.descricao,
              valorOperacao: lancamento.valor));
        }
      return lista;
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize, child: AppBarExtrato()),
      body: Column(
        children: [
          _TabBarMeses(controller: _tabController!),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              height: context.height * 0.82,
              child: Card(
                margin: const EdgeInsets.only(top: 3),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                color: Colors.white,
                surfaceTintColor: Colors.white,
                child: Column(
                  children: [
                    _MenuFiltroTelaExtrato(),
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: extratoProvider.carregarDados,
                      child: FutureBuilder(
                        future: extratoProvider.extratoFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Loader();
                          }
                          if (!snapshot.hasData) {
                            print("nao ha data");
                          }
                          return ListView.builder(
                              itemCount: tamanhoLista,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    _ItemListaExtrato(
                                      dataDia: FormatarData.formatar(
                                          extratoProvider.itensExtrato[index]
                                              .dataReferencia
                                              .toIso8601String()),
                                      saldoDia: FormatarDinheiro.BR(
                                          extratoProvider
                                              .itensExtrato[index].saldoNaData),
                                    ),
                                    ...buildOperacoes(index)
                                  ],
                                );
                              });
                        },
                      ),
                    ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
