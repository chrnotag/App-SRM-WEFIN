import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/generated/assets.dart';
import 'package:Srm_Asset/widgets/appbar_logo_perfil.dart';
import 'package:Srm_Asset/widgets/botao_selecao_empresa.dart';

import '../../../models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

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
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final AssinaturaProvider assinaturaProvider =
        Modular.get<AssinaturaProvider>();
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarLogo(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Stack(
          children: [
            Column(
              children: [
                SelecaoEmpresa(
                  nomeEmpresa: authProvider.empresaSelecionada?.nome ??
                      "Sem empresas no grupo economico",
                  changeble: true,
                ),
                Flexible(child: Container()),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          final AssinaturaProvider assinaturaProvider =
                              Modular.get<AssinaturaProvider>();
                          List<MonitorAssinaturasModel> assinaturasPendentes =
                              assinaturaProvider.assinaturasPendentes;
                          List<MonitorAssinaturasModel> assinaturas =
                              assinaturaProvider.todasAssinaturas;
                          Modular.to.pushNamed(AppRoutes.assinaturaDigitalRoute,
                              arguments: {
                                'assinaturas': assinaturas,
                                'assinaturasPendentes': assinaturasPendentes
                              });
                        },
                        child: Card(
                          child: Container(
                            height: 144.h,
                            width: 140.w,
                            child: Padding(
                              padding: EdgeInsets.all(6.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        Assets.iconsIcAssinatura,
                                        color: context.primaryColor,
                                        width: 41.w,
                                      ),
                                      if (authProvider.empresaSelecionada!
                                              .assinaturaPendente >
                                          0)
                                        CircleAvatar(
                                          radius: 13.r,
                                          backgroundColor: Colors.red,
                                          child: Text(
                                            authProvider.empresaSelecionada!
                                                        .assinaturaPendente >
                                                    9
                                                ? '9+'
                                                : authProvider
                                                    .empresaSelecionada!
                                                    .assinaturaPendente
                                                    .toString(),
                                            style: context.textTheme.bodySmall!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  SizedBox(
                                    width: 84.w,
                                    child: Text(
                                      'Assinatura Digital',
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Modular.to
                            .pushNamed(AppRoutes.monitorOperacoesRoute),
                        child: Card(
                          child: Container(
                            height: 144.h,
                            width: 140.w,
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    LineIcons.areaChart,
                                    color: context.primaryColor,
                                    size: 51.r,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Text(
                                    'Monitor de Operações',
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            Modular.to.pushNamed(AppRoutes.helpScreenRoute),
                        child: Card(
                          child: Container(
                            height: 144.h,
                            width: 140.w,
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        Assets.iconsIcAtendimento,
                                        fit: BoxFit.fill,
                                        color: context.primaryColor,
                                        width: 41.w,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Text(
                                    'Central de Atendimento',
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
