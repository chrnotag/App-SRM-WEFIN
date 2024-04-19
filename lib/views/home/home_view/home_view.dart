import 'package:Srm_Asset/core/constants/AppSizes.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
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
import '../../../core/constants/tema_configs.dart';
import '../../../models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

part 'widgets/card_item_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    final ContaDigitalProvider contaDigitalProvider = context.watch<ContaDigitalProvider>();
    return Scaffold(
      // bottomNavigationBar: SafeArea(
      //   child: BottomNavigationBar(
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     onTap: (value) {
      //       setState(() {
      //         _index = value;
      //       });
      //     },
      //     currentIndex: _index,
      //     selectedItemColor: context.indicatorColor,
      //     type: BottomNavigationBarType.fixed,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Container(
      //               decoration: BoxDecoration(
      //                   color: _index == 0 ? context.indicatorColor : null,
      //                   borderRadius: const BorderRadius.all(Radius.circular(10))),
      //               height: 4,
      //               width: 30.r,
      //             ),
      //             SvgPicture.asset(Assets.home_icon,
      //                 color: _index == 0 ? context.indicatorColor : null),
      //           ],
      //         ),
      //         label: 'Início',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Container(
      //               decoration: BoxDecoration(
      //                   color: _index == 1 ? context.indicatorColor : null,
      //                   borderRadius: BorderRadius.all(Radius.circular(10))),
      //               height: 4,
      //               width: 30.r,
      //             ),
      //             SvgPicture.asset(Assets.search_icon,
      //                 color: _index == 1 ? context.indicatorColor : null),
      //           ],
      //         ),
      //         label: 'Busca',
      //       ),
      //       BottomNavigationBarItem(
      //           icon: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Container(
      //                 decoration: BoxDecoration(
      //                     color: _index == 2 ? context.indicatorColor : null,
      //                     borderRadius: BorderRadius.all(Radius.circular(10))),
      //                 height: 4,
      //                 width: 30.r,
      //               ),
      //               SvgPicture.asset(Assets.menu_options_icon,
      //                   color: _index == 2 ? context.indicatorColor : null),
      //             ],
      //           ),
      //           label: 'Opções'),
      //     ],
      //   ),
      // ),
      backgroundColor: AppColors.brancoGelo,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarLogo(),
      ),
      body: Stack(
        children: [
          Container(
            height: context.height * 0.22,
            decoration: BoxDecoration(
                color: context.indicatorColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12))),
          ),
          Center(
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
                        Text(
                          _isSaldoVisivel ? "R\$ ${contaDigitalProvider.saldoContaDigital?.saldoTotal ?? 0.00}" : 'R\$ * * * * *',
                          style: context.textTheme.displayMedium!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                            onPressed: () => setState(() {
                                  _isSaldoVisivel = !_isSaldoVisivel;
                                }),
                            icon: Icon(
                              _isSaldoVisivel
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.brancoGelo,
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
                              icone: Assets.caneta_assinando,
                              titulo: 'Assinatura Digital',
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
                              icone: Assets.grafico_icone,
                              titulo: 'Monitor de Operações',
                              onTap: () => Modular.to
                                  .pushNamed(AppRoutes.monitorOperacoesRoute)),
                          _CardItemMenuHome(
                              icone: Assets.lista_icone,
                              titulo: 'Extrato',
                              onTap: () {}),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _CardItemMenuHome(
                              icone: Assets.balao_chat,
                              titulo: 'Fale com seu gerente',
                              onTap: () {Modular.to.pushNamed(AppRoutes.helpScreenRoute);}),
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
                              icone: Assets.dolar_icon,
                              titulo: 'Conta Garantia',
                              onTap: () {}),
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
        ],
      ),
    );
  }
}
