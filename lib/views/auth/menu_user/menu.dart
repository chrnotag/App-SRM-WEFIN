import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/generated/assets.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';

part 'widgets/menu_item.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize, child: const AppBarLogo()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          children: [
            Text('Meu Perfil',
                style: context.textTheme.bodyMedium!
                    .copyWith(color: AppColors.branco)),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text('Visualize seus dados e tire suas dúvidas',
                  style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.branco, fontWeight: FontWeight.w200)),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: SvgPicture.asset(
                              Assets.empresaIcon,
                              width: 70,
                              color: AppColors.azul,
                            ),
                          ),
                          Text(
                              authProvider.empresaSelecionada?.nome ??
                                  'Empresa não selecionada',
                              style: context.textTheme.bodyLarge!.copyWith(
                                color: AppColors.corPrimariaSRM,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                letterSpacing: 1.5,
                              )),
                        ],
                      ),
                    ),
                    _MenuItem(
                        icon: LineIcons.questionCircle,
                        title: 'Ajuda',
                        onTap: () =>
                            Modular.to.pushNamed(AppRoutes.helpScreenRoute)),
                    _MenuItem(
                        icon: Icons.exit_to_app,
                        title: 'Sair',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Column(
                                children: [
                                  const Icon(
                                    LineIcons.exclamationCircle,
                                    color: AppColors.azul,
                                    size: 80,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text('Atenção',
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          color: AppColors.corPrimariaSRM,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          letterSpacing: 1.5,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text('Deseja encerrar o aplicativo?',
                                        style: context.textTheme.labelSmall!
                                            .copyWith(
                                                color: AppColors.labelText)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              authProvider.clearDataUser();
                                              Modular.to.navigate(
                                                  Modular.initialRoute);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.azul,
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'SAIR',
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Modular.to.pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    side: const BorderSide(
                                                        color: AppColors
                                                            .azul,
                                                        width: 1))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text('CANCELAR',
                                                    style: context
                                                        .textTheme.labelSmall!
                                                        .copyWith(
                                                            color: AppColors
                                                                .azul)),
                                              ),
                                            )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                    SizedBox(height: 6)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
