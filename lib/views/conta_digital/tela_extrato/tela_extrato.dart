import 'package:Srm_Asset/core/constants/enuns/tipo_operacao_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/date_extensions.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_provider.dart';
import 'package:Srm_Asset/core/utils/data_format.dart';
import 'package:Srm_Asset/core/utils/money_format.dart';
import 'package:Srm_Asset/generated/assets.dart';
import 'package:Srm_Asset/models/conta_digital/extrato/conta_extrato_model.dart';
import 'package:Srm_Asset/views/conta_digital/tela_extrato/widgets/item_lista_extrato.dart';
import 'package:Srm_Asset/views/conta_digital/tela_extrato/widgets/item_lista_operacao.dart';
import 'package:Srm_Asset/views/conta_digital/widgets/app_bar_conta_digital.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/providers/conta_digital/tabbar_meses_provider.dart';
import '../../../core/utils/ultimo_dia_mes.dart';

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
    tamanhoLista = 7;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    final provider = Modular.get<ExtratoProvider>();
    provider.limparDados();
    tamanhoLista = 7;
  }

  @override
  Widget build(BuildContext context) {
    final extratoProvider = context.watch<ExtratoProvider>();
    List<Widget> buildOperacoes(int index) {
      return extratoProvider.itensExtrato[index].lancamentos
          .map((e) => ItemListaOperacao(
          tipoTED: TipoTED.fromCodigo(e.evento.codigo),
          descricao: e.evento.descricao,
          valorOperacao: e.valor,
          codigoTransacao: e.transacao,
          dataComprovante: e.data.formatarIso8601))
          .toList();
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize, child: AppBarExtrato()),
      body: Column(
        children: [
          _TabBarMeses(controller: _tabController!),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
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
                          if (!snapshot.hasData) {}
                          return ListView.builder(
                              itemCount: tamanhoLista,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ItemListaExtrato(
                                      dataDia:
                                          extratoProvider.itensExtrato[index]
                                              .dataReferencia.formatarIso8601,
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
