import 'dart:developer';

import 'package:Srm_Asset/generated/assets.dart';
import 'package:Srm_Asset/views/home/assinaturas/widgets/popup_erro_carregar_dados.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:Srm_Asset/views/home/assinaturas/widgets/mensagem_lista_vazia.dart';
import 'package:Srm_Asset/widgets/appbar_logo_perfil.dart';
import 'package:Srm_Asset/widgets/botao_selecao_empresa.dart';
import 'package:Srm_Asset/widgets/card_monitor_assinaturas/card_monitor_assinaturas.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';

import '../../../core/implementations_config/api_response.dart';

class MonitorAssinaturas extends StatefulWidget {
  const MonitorAssinaturas({super.key});

  @override
  State<MonitorAssinaturas> createState() => _MonitorAssinaturasState();
}

class _MonitorAssinaturasState extends State<MonitorAssinaturas>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<ApiResponse<dynamic>> _assinaturasFuture;

  final AssinaturaProvider assinaturaProvider =
      Modular.get<AssinaturaProvider>();

  @override
  void initState() {
    super.initState();
    _carregarDados();
    _tabController = TabController(vsync: this, length: 2);
    if (Modular.args.data != null && Modular.args.data.containsKey('tab')) {
      _tabController.animateTo(Modular.args.data['tab']);
    }
  }

  Future<void> _carregarDados() async {
    setState(() {
      _assinaturasFuture =
          Modular.get<AssinaturaProvider>().carregarAssinaturas();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    assinaturaProvider.isDestacado = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final AssinaturaProvider assinaturaProvider =
        context.watch<AssinaturaProvider>();
    bool? destacar;
    if (Modular.args.data != null &&
        Modular.args.data.containsKey('destacar')) {
      destacar = Modular.args.data['destacar'];
    }
    final List<MonitorAssinaturasModel> assinaturasPendentes =
        assinaturaProvider.assinaturasPendentes;
    final List<MonitorAssinaturasModel> assinaturas =
        assinaturaProvider.todasAssinaturas;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: const AppBarLogo(),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                SelecaoEmpresa(
                  nomeEmpresa: authProvider.empresaSelecionada?.nome,
                  changeble: true,
                  tituloPagina: 'Assinatura Digital',
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.r),
                      ),
                    ),
                    child: TabBar(
                        dividerColor: Colors.transparent,
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                                color: context.indicatorColor, width: 7.h)),
                        tabs: [
                          Tab(
                            child: Text("Assinaturas Pendentes",
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w600)),
                            height: 50.h,
                          ),
                          Tab(
                              child: Text("Acompanhar Assinaturas",
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w600)),
                              height: 50.h),
                        ],
                        indicatorColor: context.primaryColor),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      FutureBuilder(
                        future: _assinaturasFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Loader();
                          } else if (snapshot.hasError) {
                            showDialog(
                              context: context,
                              builder: (context) => PopUpErroCarregarDados(),
                            );
                          }
                          if (assinaturasPendentes.isEmpty) {
                            return Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 116.h),
                                    child: Icon(LineIcons.checkCircle,
                                        color: context.primaryColor,
                                        size: 137.r),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 25.h),
                                    child: Text(
                                      "Nada pendente!\nTodas as assinaturas estão em dia.",
                                      textAlign: TextAlign.center,
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                              color: context.indicatorColor,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return RefreshIndicator(
                            backgroundColor: Colors.white,
                            color: context.primaryColor,
                            onRefresh: () => _carregarDados(),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: assinaturasPendentes.length,
                              itemBuilder: (context, index) =>
                                  CardMonitorAssinaturas(
                                assinarDocumento: true,
                                assinatura: assinaturasPendentes[index],
                              ),
                            ),
                          );
                        },
                      ),
                      FutureBuilder(
                          future: _assinaturasFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Loader();
                            } else if (snapshot.hasError) {
                              showDialog(
                                context: context,
                                builder: (context) => PopUpErroCarregarDados(),
                              );
                            }
                            if (assinaturas.isEmpty) {
                              return Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 137.h),
                                      child: Icon(
                                        LineIcons.clipboardWithCheck,
                                        color: context.primaryColor,
                                        size: 116.r,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 25.h),
                                      child: Text(
                                        "Não há assinaturas para\nacompanhamento.",
                                        textAlign: TextAlign.center,
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                                color: context.indicatorColor,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return RefreshIndicator(
                              backgroundColor: Colors.white,
                              color: context.primaryColor,
                              onRefresh: () => _carregarDados(),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: assinaturas.length,
                                itemBuilder: (context, index) =>
                                    CardMonitorAssinaturas(
                                  assinatura: assinaturas[index],
                                  destacar: index == 0 &&
                                      destacar != null &&
                                      destacar &&
                                      !assinaturaProvider.isDestacado,
                                  visualizarDocumento: true,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
