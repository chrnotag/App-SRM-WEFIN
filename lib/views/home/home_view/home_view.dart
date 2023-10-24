import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/generated/assets.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:modular_study/widgets/botao_selecao_empresa.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final AssinaturaProvider assinaturaProvider =
        Modular.get<AssinaturaProvider>();
    double spacing = 20; // Espaço entre os widgets
    double totalSpacing = 3 * spacing; // Espaço total entre os widgets
    double widthCard = (MediaQuery.of(context).size.width - totalSpacing) / 3;
    double heigthCard = widthCard * 1.3;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarLogo(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              children: [
                SelecaoEmpresa(
                  nomeEmpresa: authProvider.empresaSelecionada!.nome,
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
                          Modular.to
                              .pushNamed(AppRoutes.assinaturaDigitalRoute);
                        },
                        child: Card(
                          child: Container(
                            height: heigthCard,
                            width: widthCard,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        Assets.iconsIcAssinatura,
                                        color: AppColors.botaoEnvio,
                                      ),
                                      if (assinaturaProvider
                                              .assinaturasPendentes
                                              .isNotEmpty &&
                                          assinaturaProvider
                                                  .assinaturasPendentes.length >
                                              0)
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.red,
                                          child: Text(
                                            assinaturaProvider
                                                        .assinaturasPendentes
                                                        .length >
                                                    99
                                                ? '99+'
                                                : assinaturaProvider
                                                    .notificacaoPendentes(),
                                            style: context.textTheme.bodySmall!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'Assinatura Digital',
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.globalBackground),
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
                            height: heigthCard,
                            width: widthCard,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    LineIcons.areaChart,
                                    color: AppColors.botaoEnvio,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'Monitor de Operação',
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.globalBackground),
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
                            height: heigthCard,
                            width: widthCard,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
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
                                        color: AppColors.botaoEnvio,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'Central de Atendimento',
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.globalBackground),
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
