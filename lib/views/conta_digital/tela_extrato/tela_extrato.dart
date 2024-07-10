import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/extensions/date_extensions.dart';
import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/string_extensions.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_impl.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_provider.dart';
import 'package:Srm_Asset/views/conta_digital/tela_extrato/widgets/item_lista_extrato.dart';
import 'package:Srm_Asset/views/conta_digital/widgets/app_bar_conta_digital.dart';
import 'package:Srm_Asset/views/conta_digital/widgets/lista_operacao.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/configs_tema/srm/colors.dart';
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
    super.dispose();
    final provider = Modular.get<ExtratoProvider>();
    provider.limparDados();
    tamanhoLista = 7;
  }

  @override
  Widget build(BuildContext context) {
    final extratoProvider = context.watch<ExtratoProvider>();
    final ambiente = Modular.get<Environment>();

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

                            if (extratoProvider.extrato != null &&
                                extratoProvider.extrato!.itens.isNotEmpty) {
                              // Ajuste o tamanho da lista para não exceder o tamanho de itensExtrato
                              final itemCount = extratoProvider.itensExtrato.length < tamanhoLista
                                  ? extratoProvider.itensExtrato.length
                                  : tamanhoLista;

                              return ListView.builder(
                                itemCount: itemCount,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ItemListaExtrato(
                                        dataDia: extratoProvider
                                            .itensExtrato[index]
                                            .dataReferencia
                                            .formatarIso8601,
                                        saldoDia: extratoProvider
                                            .itensExtrato[index]
                                            .saldoNaData
                                            .toBRL,
                                      ),
                                      ...BuildListaOperacao.buildLista(
                                        context: context,
                                        index: index,
                                        tipoConsulta: TipoConsultaExtrato
                                            .VISUALIZAR,
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(ambiente.alerta_icone),
                                    Padding(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 50.h),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Não há movimentações disponíveis',
                                            style: context.textTheme
                                                .displaySmall!
                                                .copyWith(
                                                color:
                                                SRMColors.textBodyColor,
                                                fontWeight:
                                                FontWeight.w900),
                                          ),
                                          Text(
                                            'Não existem movimentações no periodo selecionado.',
                                            style: context.textTheme.bodyLarge!
                                                .copyWith(
                                                color: context
                                                    .labelTextColor),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    )
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
