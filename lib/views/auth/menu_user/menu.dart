import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/auth_provider_config/deslogar/deslogar_impl.dart';
import 'package:modular_study/core/providers/auth_provider_config/deslogar/deslogar_controller.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/generated/assets.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';

import '../../../core/constants/enuns/theme_enum.dart';
import '../../../core/providers/theme_provider.dart';

part 'widgets/menu_item.dart';

part 'widgets/popup_sair.dart';

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
                style: context.textTheme.bodyMedium!.copyWith(color: context.onSecondary)),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text('Visualize seus dados e tire suas dúvidas',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: context.onSecondary,
                      fontWeight: FontWeight.w200)),
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
                              color: context.primaryColor,
                            ),
                          ),
                          Text(
                            authProvider.empresaSelecionada?.nome ??
                                'Empresa não selecionada',
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
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
                            builder: (context) => PopUpDeslogarApp(
                                    context: context,
                                    authProvider: authProvider)
                                .popUp,
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
