import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/AppSizes.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/generated/assets.dart';
import 'package:Srm_Asset/widgets/appbar_logo_perfil.dart';
import '../../../core/implementations_config/api_response.dart';
import '../../../models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

part 'widgets/card_item_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<ApiResponse<dynamic>> _saldoFuture;
  final contaDigital = Modular.get<ContaDigitalProvider>();

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() {
      _saldoFuture =
          contaDigital.carregarSaldo(contaDigital.dadosContaDigital!.conta);
    });
  }

  @override
  void dispose() {
    final AssinaturaProvider assinaturaProvider =
        Modular.get<AssinaturaProvider>();
    assinaturaProvider.limparAssinaturas();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final SessionProvider sessaoProvider = Modular.get<SessionProvider>();
    sessaoProvider.resetListening();
  }

  int _index = 0;
  bool _isSaldoVisivel = false;

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    final ContaDigitalProvider contaDigitalProvider =
        context.watch<ContaDigitalProvider>();
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          backgroundColor: context.backgroundColor,
          elevation: 0,
          onTap: (value) {
            setState(() {
              _index = value;
            });
          },
          currentIndex: _index,
          selectedItemColor: context.secondaryColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: _index == 0 ? context.secondaryColor : null,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    height: 4,
                    width: 30.r,
                  ),
                  SvgPicture.asset(Assets.home_icon,
                      color: _index == 0 ? context.secondaryColor : null),
                ],
              ),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: _index == 1 ? context.secondaryColor : null,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 4,
                    width: 30.r,
                  ),
                  SvgPicture.asset(Assets.search_icon,
                      color: _index == 1 ? context.secondaryColor : null),
                ],
              ),
              label: 'Busca',
            ),
            BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: _index == 2 ? context.secondaryColor : null,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 4,
                      width: 30.r,
                    ),
                    SvgPicture.asset(Assets.menu_options_icon,
                        color: _index == 2 ? context.secondaryColor : null),
                  ],
                ),
                label: 'Opções'),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBarLogo(),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: context.height * 0.22,
              decoration: BoxDecoration(
                  color: context.secondaryColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(12))),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: AppSizes.paddingLarge.h),
                    child: Text(
                      'Conta Digital',
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Column(
                    children: [
                      Text('Saldo Disponível',
                          style: context.textTheme.bodySmall!
                              .copyWith(color: Colors.white)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder(
                              future: _saldoFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator(
                                    color: context.primaryColor,
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                      'Houve um erro ao carregar o saldo!');
                                } else {
                                  return Text(
                                    _isSaldoVisivel
                                        ? contaDigitalProvider.saldoContaDigital
                                                ?.saldoTotal.toBRL ??
                                            0.0.toBRL
                                        : 'R\$ * * * * *',
                                    style: context.textTheme.displayMedium!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900),
                                  );
                                }
                              }),
                          IconButton(
                              onPressed: () => setState(() {
                                    _isSaldoVisivel = !_isSaldoVisivel;
                                  }),
                              icon: Icon(
                                _isSaldoVisivel
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: context.backgroundColor,
                              ))
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: AppSizes.paddingExtraLarge.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _CardItemMenuHome(
                                icone: Assets.grafico_icone,
                                titulo: 'Monitor de Operações',
                                notificacoes: authProvider
                                    .empresaSelecionada!.assinaturaPendente,
                                onTap: () {
                                  final AssinaturaProvider assinaturaProvider =
                                      Modular.get<AssinaturaProvider>();
                                  List<MonitorAssinaturasModel>
                                      assinaturasPendentes =
                                      assinaturaProvider.assinaturasPendentes;
                                  List<MonitorAssinaturasModel> assinaturas =
                                      assinaturaProvider.todasAssinaturas;
                                  Modular.to.pushNamed(
                                      AppRoutes.assinaturaDigitalRoute,
                                      arguments: {
                                        'assinaturas': assinaturas,
                                        'assinaturasPendentes':
                                            assinaturasPendentes
                                      });
                                }),
                            _CardItemMenuHome(
                                icone: Assets.lista_icone,
                                titulo: 'Extrato',
                                onTap: () {
                                  Modular.to
                                      .pushNamed(AppRoutes.extratoScreenRoute);
                                }),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _CardItemMenuHome(
                                icone: Assets.balao_chat,
                                titulo: 'Fale com seu gerente',
                                onTap: () {
                                  Modular.to
                                      .pushNamed(AppRoutes.helpScreenRoute);
                                }),
                            _CardItemMenuHome(
                                icone: Assets.setas_perpendiculares,
                                titulo: 'Transferências',
                                onTap: () {}),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _CardItemMenuHome(
                                icone: AssetsConfig.imagesCarteiraConsolidada,
                                titulo: 'Carteira Consolidada',
                                onTap: () {
                                  Modular.to.pushNamed(AppRoutes
                                      .carteiraConsolidadaNavigatorRoute);
                                }),
                            _CardItemMenuHome(
                                icone: Assets.grupo_pessoas,
                                titulo: 'Grupo Econômico',
                                onTap: () {}),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
