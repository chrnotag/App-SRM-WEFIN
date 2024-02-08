import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/extensions/screen_util_extension.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:modular_study/views/home/assinaturas/widgets/mensagem_lista_vazia.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:modular_study/widgets/botao_selecao_empresa.dart';
import 'package:modular_study/widgets/card_monitor_assinaturas/card_monitor_assinaturas.dart';
import 'package:modular_study/widgets/loader_widget.dart';

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
    if (Modular.args.data['tab'] != null) {
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
    final args = Modular.args.data;
    final List<MonitorAssinaturasModel> assinaturasPendentes =
        assinaturaProvider.assinaturasPendentes;
    final List<MonitorAssinaturasModel> assinaturas =
        assinaturaProvider.todasAssinaturas;
    final bool? destacar = args['destacar'];
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
              Card(
                child: TabBar(
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text("Assinaturas Pendentes",
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyMedium),
                      height: 40.h,
                    ),
                    Tab(
                        child: Text("Acompanhar Assinaturas",
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyMedium),
                        height: 40.h),
                  ],
                  indicatorColor: context.primaryColor),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: assinaturasPendentes.length,
                    itemBuilder: (context, index) => CardMonitorAssinaturas(
                      assinarDocumento: true,
                      assinatura: assinaturasPendentes[index],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: assinaturas.length,
                    itemBuilder: (context, index) => CardMonitorAssinaturas(
                      assinatura: assinaturas[index],
                      destacar: index == 0 &&
                          destacar != null &&
                          destacar &&
                          !assinaturaProvider.isDestacado,
                      visualizarDocumento: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
