import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/AppSizes.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/enuns/plataforma_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';

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
import 'package:Srm_Asset/generated/assets.dart';
import 'package:Srm_Asset/widgets/appbar_logo_perfil.dart';
import '../../../core/constants/enuns/RolesAcessoEnum.dart';
import '../../../core/implementations_config/api_response.dart';
import '../../../models/auth_login_models/SRM/cedente_model.dart';
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
          icone: AssetsConfig.imagesGraficoVetor,
          titulo: 'Monitor de Operações',
          notificacoes: authProvider.empresaSelecionada!.assinaturaPendente,
          onTap: () {
            final AssinaturaProvider assinaturaProvider =
                Modular.get<AssinaturaProvider>();
            List<MonitorAssinaturasModel> assinaturasPendentes =
                assinaturaProvider.assinaturasPendentes;
            List<MonitorAssinaturasModel> assinaturas =
                assinaturaProvider.todasAssinaturas;
            Modular.to.pushNamed(AppRoutes.assinaturaDigitalRoute, arguments: {
              'assinaturas': assinaturas,
              'assinaturasPendentes': assinaturasPendentes
            });
          }),
      _CardItemMenuHome(
          icone: Assets.setas_perpendiculares,
          titulo: 'Transferências',
          onTap: () {}),
      _CardItemMenuHome(
          icone: AssetsConfig.imagesExtratoVetor,
          titulo: 'Extrato',
          onTap: () {
            Modular.to.pushNamed(AppRoutes.extratoScreenRoute);
          }),
      _CardItemMenuHome(
          icone: ambiente.ted_menu_icone,
          titulo: 'Ted para Terceiros',
          onTap: () {
            Modular.to.pushNamed(AppRoutes.tedTerceirosNavigatorRoute);
          }),
      isSRM
          ? _CardItemMenuHome(
              icone: AssetsConfig.imagesCarteiraConsolidada,
              titulo: 'Carteira Consolidada',
              onTap: () {
                Modular.to
                    .pushNamed(AppRoutes.carteiraConsolidadaNavigatorRoute);
              })
          : _CardItemMenuHome(
              icone: AssetsConfig.imagesDocumentoVetor,
              titulo: 'Relatório de Títulos',
              onTap: () {
                Modular.to
                    .pushNamed(AppRoutes.carteiraConsolidadaNavigatorRoute);
              }),
      _CardItemMenuHome(
          icone: Assets.grupo_pessoas,
          titulo: 'Grupo Econômico',
          onTap: () {
            Modular.to.navigate(AppRoutes.listaSelecaoEmpresasRoute);
          }),
      _CardItemMenuHome(
          icone: isSRM ? Assets.balao_chat : AssetsConfig.imagesWhatsappVetor,
          titulo: 'Fale conosco',
          onTap: () {
            Modular.to.pushNamed(AppRoutes.helpScreenRoute);
          }),
    ];

    if (!authProvider.rolesAcesso!
        .contains(RolesAcessoEnum.ROLE_MONITOR_OPERACOES)) {
      cardsHome.removeWhere((card) =>
          (card as _CardItemMenuHome).titulo == 'Monitor de Operações');
    }

    int rowCount = (cardsHome.length / 3).ceil();
    double gridViewHeight = rowCount * 210.h;

    bool acessoContaDigital =
        authProvider.rolesAcesso!.contains(RolesAcessoEnum.ROLE_CONTA_DIGITAL);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 190.h,
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
                Padding(
                  padding: EdgeInsets.only(top: 35.h),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              ambiente.logoAppBar,
                              width: 24.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: context.width * 0.7,
                                  height: 40.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppSizes.paddingSmall),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12))),
                                  child: DropdownButton(
                                    dropdownColor: Colors.white,
                                    value: _valorSelecionado,
                                    selectedItemBuilder: (context) => _listaItens
                                        .map((e) => DropdownMenuItem(
                                              value: e.identificador,
                                              child: Text("Olá, ${e.nome}",
                                                  style: context.textTheme.bodyMedium!
                                                      .copyWith(color: Colors.white),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis),
                                            ))
                                        .toList(),
                                    menuMaxHeight: 300.h,
                                    isExpanded: true,
                                    items: _listaItens
                                        .map((e) => DropdownMenuItem(
                                              value: e.identificador,
                                              child: Text(e.nome,
                                                  style: context.textTheme.bodyMedium!
                                                      .copyWith(color: Colors.black),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis),
                                            ))
                                        .toList(),
                                    onChanged: (value) async {
                                      setState(() {
                                        _valorSelecionado = value!;
                                      });
                                      await authProvider.RelogarTrocarCedente(
                                          value!, context);
                                    },
                                    underline: Container(),
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(color: Colors.white),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: Text(
                                    'Conta Digital',
                                    style: context.textTheme.displaySmall!.copyWith(
                                        color: Colors.white, fontWeight: FontWeight.w900),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                                return Text(
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
                                                      fontWeight: FontWeight.w900),
                                                );
                                              }
                                            }),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () => setState(() {
                                        _isSaldoVisivel = !_isSaldoVisivel;
                                      }),
                                      icon: Icon(
                                        _isSaldoVisivel
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: context.backgroundColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SvgPicture.asset(
                              AssetsConfig.imagesExitIcone,
                              width: 30.w,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: -context.width * 0.15,
                  top: -90.h,
                  child: SvgPicture.asset(
                    ambiente.logoAppBar,
                    color: Color(0x1affffff),
                    width: context.width * 0.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: context.width,
            height: context.height * 0.78,
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
