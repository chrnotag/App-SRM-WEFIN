import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/extensions/string_extensions.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/utils/ambiente_atual.dart';
import 'package:Srm_Asset/widgets/transparent_appbar_empty.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/deslogar/deslogar_controller.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';

part 'widgets/menu_item.dart';

part 'widgets/popup_sair.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("dd/MM/yyyy 'às' hh:mm:ss");
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final contaProvider = Modular.get<ContaDigitalProvider>();
    final ambiente = Modular.get<Environment>();
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 25.h, 25.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meu Perfil',
                    style: context.textTheme.displaySmall!.copyWith(
                        color: SRMColors.textBodyColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Visualise os dados do Cedente.',
                    style: context.textTheme.bodyLarge!
                        .copyWith(color: context.labelTextColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.only(bottom: 20.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Container(
                              height: 200.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                  color: context.secondaryColor.withAlpha(10),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r))),
                              child: Center(
                                child: SvgPicture.asset(
                                    AssetsConfig.srmMaletaPerfil, color: context.secondaryColor,),
                              ),
                            ),
                          ),
                          _ItemMenu(
                              title: 'cedente',
                              content: authProvider.empresaSelecionada!.nome),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: _ItemMenu(
                                title: 'CPF/CNPJ',
                                content: authProvider.dataUser!
                                            .identificadorUsuario.length >
                                        11
                                    ? UtilBrasilFields.obterCnpj(authProvider
                                        .dataUser!.identificadorUsuario)
                                    : UtilBrasilFields.obterCpf(authProvider
                                        .dataUser!.identificadorUsuario)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: _ItemMenu(
                              title: 'Dados Bancários',
                              content:
                                  '${contaProvider.dadosContaDigital!.codigoBanco} ${contaProvider.dadosContaDigital!.agencia} ${contaProvider.dadosContaDigital!.conta.digitoConta}',
                            ),
                          ),
                          // _ItemMenu(
                          //     title: 'Último acesso',
                          //     content: dateFormat.format(
                          //         authProvider.dataUser!.dataExpiraSessao))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
