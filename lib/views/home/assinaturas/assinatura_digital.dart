import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:modular_study/widgets/botao_selecao_empresa.dart';
import 'package:modular_study/widgets/card_monitor_assinaturas/card_monitor_assinaturas.dart';

class AssinaturaDigital extends StatefulWidget {
  const AssinaturaDigital({super.key});

  @override
  State<AssinaturaDigital> createState() => _AssinaturaDigitalState();
}

class _AssinaturaDigitalState extends State<AssinaturaDigital>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final AssinaturaProvider assinaturaProvider =
        Modular.get<AssinaturaProvider>();
    List<AssinaturasModel> assinaturasPendentes = assinaturaProvider.assinaturasPendentes;
    List<AssinaturasModel> assinaturas = assinaturaProvider.todasAssinaturas;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const AppBarLogo(),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SelecaoEmpresa(
              nomeEmpresa: authProvider.empresaSelecionada!.nome,
              changeble: true,
              tituloPagina: 'Assinatura Digital',
            ),
            Card(
              child: TabBar(controller: _tabController, tabs: [
                Tab(
                  child: Text("Assinaturas Pendentes",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: AppColors.corPrimariaSRM)),
                ),
                Tab(
                    child: Text("Acompanhar Assinaturas",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: AppColors.corPrimariaSRM))),
              ]),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: assinaturas.length,
                    itemBuilder: (context, index) => CardMonitorAssinaturas(
                      assinarDocumento: true,
                      assinatura: assinaturas[index],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: assinaturasPendentes.length,
                    itemBuilder: (context, index) => CardMonitorAssinaturas(
                      assinatura: assinaturasPendentes[index],
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
