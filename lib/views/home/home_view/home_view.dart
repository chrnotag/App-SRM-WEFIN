import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/AppSizes.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/roles_extensions.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'package:Srm_Asset/widgets/appbar_logo_perfil.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import '../../../core/constants/enuns/plataforma_enum.dart';
import '../../../core/constants/enuns/roles_acesso_enum.dart';
import '../../../core/implementations_config/api_response.dart';
import '../../../core/providers/auth_provider_config/deslogar/deslogar_controller.dart';
import '../../../models/auth_login_models/SRM/cedente_model.dart';
import '../../../models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

part 'widgets/card_item_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<ApiResponse<dynamic>>? _saldoFuture;
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

  late String _valorSelecionado;
  List<CedenteModel> _listaItens = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final SessionProvider sessaoProvider = Modular.get<SessionProvider>();
    sessaoProvider.resetListening();
    final authProvider = context.watch<AuthProvider>();
    _valorSelecionado = authProvider.empresaSelecionada!.identificador;
    _listaItens = authProvider.listaCedente!;
  }

  bool _isSaldoVisivel = false;

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    final ContaDigitalProvider contaDigitalProvider =
        context.watch<ContaDigitalProvider>();
    final ambiente = Modular.get<Environment>();
    bool isSRM = ambiente.plataforma == Plataforma.SRM;

    List<Widget> cardsHome = [
      _CardItemMenuHome(
          icone: ambiente.monitorOperacoesIcone,
          titulo: 'Monitor de Operações',
          notificacoes: authProvider.empresaSelecionada!.assinaturaPendente,
          onTap: () {
            final AssinaturaProvider assinaturaProvider =
                Modular.get<AssinaturaProvider>();
            List<MonitorAssinaturasModel> assinaturasPendentes =
                assinaturaProvider.assinaturasPendentes;
            List<MonitorAssinaturasModel> assinaturas =
                assinaturaProvider.todasAssinaturas;
            Modular.to.pushNamed(AppRoutes.assinaturaDigitalNavigatorRoute, arguments: {
              'assinaturas': assinaturas,
              'assinaturasPendentes': assinaturasPendentes
            });
          }),
      _CardItemMenuHome(
          icone: ambiente.transferenciasIcone,
          titulo: 'Transferências',
          onTap: () => Modular.to.pushNamed(AppRoutes.transferenciasNavigatorRoute)),
      _CardItemMenuHome(
          icone: ambiente.extratoIcone,
          titulo: 'Extrato',
          onTap: () {
            Modular.to.pushNamed(AppRoutes.extratoNavigatorRoute);
          }),
      _CardItemMenuHome(
          icone: ambiente.ted_menu_icone,
          titulo: 'Aprovação TED',
          onTap: () {
            Modular.to.pushNamed(AppRoutes.tedTerceirosNavigatorRoute);
          }),
      isSRM
          ? _CardItemMenuHome(
              icone: AssetsConfig.srmCarteiraConsolidada,
              titulo: 'Carteira Consolidada',
              onTap: () {
                Modular.to
                    .pushNamed(AppRoutes.carteiraConsolidadaNavigatorRoute);
              })
          : _CardItemMenuHome(
              icone: AssetsConfig.trustRelatorioTrust,
              titulo: 'Relatório de Títulos',
              onTap: () {
                Modular.to
                    .pushNamed(AppRoutes.carteiraConsolidadaNavigatorRoute);
              }),
      if (isSRM)
        _CardItemMenuHome(
            icone: ambiente.grupoEconomicoIcone!,
            titulo: 'Grupo Econômico',
            onTap: () {
              Modular.to.navigate(AppRoutes.listaSelecaoEmpresasNavigatorRoute);
            }),
      _CardItemMenuHome(
          icone: ambiente.faleConoscoIcone,
          titulo: 'Fale conosco',
          onTap: () {
            Modular.to.pushNamed(AppRoutes.helpScreenNavigatorRoute);
          }),
    ];

    // if (!authProvider.rolesAcesso
    //     .contemRoles([RolesAcessoEnum.ROLE_CONTA_DIGITAL])) {
    if (!isSRM) {
      cardsHome.removeWhere((card) =>
          (card as _CardItemMenuHome).titulo == 'Carteira Consolidada');
    }
    cardsHome.removeWhere(
        (card) => (card as _CardItemMenuHome).titulo == 'Relatório de Títulos');
    // cardsHome.removeWhere(
    //     (card) => (card as _CardItemMenuHome).titulo == 'Extrato');
    // }

    // if (!authProvider.rolesAcesso
    //     .contemRoles([RolesAcessoEnum.ROLE_TRANSFERENCIA_CONTA_DIGITAL])) {
    // }
    //
    // if (!authProvider.rolesAcesso
    //     .contemRoles([RolesAcessoEnum.ROLE_APROVACAO_TED_CONTA_GARANTIA])) {
    // cardsHome.removeWhere(
    //     (card) => (card as _CardItemMenuHome).titulo == 'Transferências');
    // }

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 16.h),
            width: context.width,
            decoration: BoxDecoration(
              color: context.secondaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                ambiente.plataforma == Plataforma.TRUST
                    ? Positioned(
                      left: -context.width * 0.1,
                      top: -40.h,
                      child: SvgPicture.asset(
                        ambiente.logoAppBar,
                        color: Color(0x1affffff),
                        width: context.width * 0.5,
                      ),
                    )
                    : Positioned(
                  left: -context.width * 0.1,
                  top: -50.h,
                  child: SvgPicture.asset(
                    ambiente.logoAppBar,
                    color: Color(0x1affffff),
                    width: context.width * 0.4,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PreferredSize(
                        preferredSize: AppBar().preferredSize,
                        child: const AppBarLogo()),
                    Padding(
                      padding: EdgeInsets.only(left: context.width * 0.12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Text(
                              'Conta Digital',
                              style: context.textTheme.displaySmall!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Saldo Disponível',
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(color: Colors.white)),
                                  FutureBuilder(
                                      future: _saldoFuture,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator(
                                            color: Colors.white,
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Houve um erro ao carregar o saldo!');
                                        } else {
                                          return Row(
                                            children: [
                                              Text(
                                                _isSaldoVisivel
                                                    ? contaDigitalProvider
                                                    .saldoContaDigital
                                                    ?.saldoTotal
                                                    .toBRL ??
                                                    0.0.toBRL
                                                    : 'R\$ * * * * *',
                                                style: context
                                                    .textTheme.displayMedium!
                                                    .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.w900),
                                              ),
                                              SizedBox(width: 8.w),
                                              GestureDetector(
                                                onTap: () => setState(() {
                                                  _isSaldoVisivel =
                                                  !_isSaldoVisivel;
                                                  print('novo valor: $_isSaldoVisivel');
                                                }),
                                                child: Icon(
                                                  _isSaldoVisivel
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color:
                                                  context.backgroundColor,
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                      }),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: context.width,
            height: context.height * 0.70,
            child: GridView.count(
              padding: EdgeInsets.all(20.r),
              crossAxisCount: 2,
              children: cardsHome,
            ),
          ),
        ],
      ),
    );
  }
}
