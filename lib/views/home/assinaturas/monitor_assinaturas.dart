import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/screen_util_extension.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:modular_study/widgets/botao_selecao_empresa.dart';
import 'package:modular_study/widgets/card_monitor_assinaturas/card_monitor_assinaturas.dart';

class MonitorAssinaturas extends StatefulWidget {
  const MonitorAssinaturas({super.key});

  @override
  State<MonitorAssinaturas> createState() => _MonitorAssinaturasState();
}

class _MonitorAssinaturasState extends State<MonitorAssinaturas>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final AssinaturaProvider assinaturaProvider =
      Modular.get<AssinaturaProvider>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    if (Modular.args.data['tab'] != null) {
      _tabController.animateTo(Modular.args.data['tab']);
    }
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
    final args = Modular.args.data;
    final assinaturasPendentes = args['assinaturasPendentes'];
    final assinaturas = args['assinaturas'];
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
              nomeEmpresa: authProvider.empresaSelecionada!.nome,
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
                indicatorColor: context.primaryColor,
                indicatorSize: TabBarIndicatorSize.label,
              ),
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
