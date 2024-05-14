import 'dart:ffi';

import 'package:Srm_Asset/core/constants/enuns/tipo_operacao_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/constants/tema_configs.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_provider.dart';
import 'package:Srm_Asset/core/utils/money_format.dart';
import 'package:Srm_Asset/generated/assets.dart';
import 'package:Srm_Asset/models/conta_digital/extrato/conta_extrato_model.dart';
import 'package:Srm_Asset/views/conta_digital/widgets/app_bar_conta_digital.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../core/implementations_config/api_response.dart';
import '../../../core/providers/conta_digital/tabbar_meses_provider.dart';

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

class _TelaExtratoState extends State<TelaExtrato>
    with TickerProviderStateMixin {
  TabController? _tabController;
  late Future<ApiResponse<dynamic>> _extrato;
  final contaDigitalProvider = Modular.get<ContaDigitalProvider>();
  final extratoProvider = Modular.get<ExtratoProvider>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2);
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() {
      _extrato = Modular.get<ExtratoProvider>().pegarExtratos(
          contaDigitalProvider.dadosContaDigital!.conta,
          extratoProvider.dataInicial,
          extratoProvider.dataFinal);
    });
  }

  List<Widget> _operacoes = [];

  List<Widget> _buildOperacoes() {
    List<ContaExtratoModel> extratos = Modular.get<ExtratoProvider>().extrato;
    print(extratos.length);
    final dataFormat = DateFormat('dd/MM/yyyy');
    for (var extrato in extratos) {
      print('extrato: ${extrato.data}');
      _operacoes.add(_ItemListaExtrato(
          dataDia: dataFormat.format(extrato.data),
          saldoDia: extrato.itens[0].saldoNaData.toString()));
    }
    return _operacoes;
  }

  @override
  Widget build(BuildContext context) {
    _buildOperacoes();
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
                      onRefresh: _carregarDados,
                      child: FutureBuilder(
                        future: _extrato,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Loader();
                          }
                          return ListView.builder(
                            itemCount: extratoProvider.intervaloDias,
                            itemBuilder: (context, index) => Container(),
                          );
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
