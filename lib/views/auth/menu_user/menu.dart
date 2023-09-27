import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/route_labels.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        child: Column(
          children: [
            const Text('Meu Perfil'),
            const Text('Visualize seus dados e tire suas dúvidas'),
            Expanded(
              child: Card(
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            Assets.empresaIcon,
                            width: 50,
                          ),
                          Text(authProvider.empresaSelecionada!.nome),
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
                                  SvgPicture.asset(
                                    Assets.iconsIcAlerta,
                                    width: 50,
                                  ),
                                  const Text('Atenção!'),
                                  const Text(
                                      'Deseja realmente sair do aplicativo?'),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Text('Sair'),
                                            )),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Text('Cancelar'),
                                            )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })
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
