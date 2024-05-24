import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/utils/ambiente_atual.dart';
import 'package:Srm_Asset/widgets/transparent_appbar_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/deslogar/deslogar_controller.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/generated/assets.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';

part 'widgets/menu_item.dart';

part 'widgets/popup_sair.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize, child: const TransparentAppBarEmpty()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          
          children: [
            Text('Meu Perfil',
                style: context.textTheme.bodyLarge!.copyWith(color: context.inverseSurfaceColor)),
            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: Text('Visualize seus dados e tire suas dúvidas',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.inverseSurfaceColor)),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30.r),
                            child: SvgPicture.asset(
                              Assets.empresaIcon,
                              width: 70.w,
                              color: context.focusColor,
                            ),
                          ),
                          Text(
                            authProvider.empresaSelecionada?.nome ??
                                'Empresa não selecionada',
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                              color: VerificarAmbiente.isSRM ? SRMColors.secondaryColor : Colors.black
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
                    SizedBox(height: 6.h)
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
