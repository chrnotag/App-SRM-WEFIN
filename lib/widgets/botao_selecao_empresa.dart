import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:line_icons/line_icons.dart';
import '../flavors.dart';
import '../generated/assets.dart';

class SelecaoEmpresa extends StatelessWidget {
  final String? nomeEmpresa;
  final String tituloPagina;
  final bool changeble;

  const SelecaoEmpresa({
    super.key,
    this.nomeEmpresa,
    this.tituloPagina = '',
    this.changeble = true,
  });

  bool mostrarIconeTrocarCedente(){
    return changeble && F.name == Flavor.SRM_PRODUCAO.name || F.name == Flavor.SRM_HOMOLOGACAO.name;
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    return Column(
      children: [
        Visibility(
          visible: tituloPagina.isNotEmpty,
          child: Text(
            tituloPagina,
            style: context.textTheme.bodyLarge!.copyWith(
                color:  context.inverseSurface, fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: context.onSecondary, width: 0.5.w, strokeAlign: 1),
              borderRadius: BorderRadius.circular(30.r)),
          child: InkWell(
            onTap: changeble && authProvider.listaCedente!.length > 1
                ? () {
                    Modular.to
                        .navigate(AppRoutes.listaSelecaoEmpresasRoute);
                  }
                : null,
            borderRadius: BorderRadius.circular(50.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: context.width * 0.8,
                    child: Text(
                      nomeEmpresa ?? "Nenhuma Empresa Selecionada",
                      style: context.textTheme.displaySmall!
                          .copyWith(color: context.inverseSurface, fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,

                    ),
                  ),
                  Visibility(
                    visible: mostrarIconeTrocarCedente(),
                    child: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Icon(
                          LineIcons.alternateExchange,
                          color: context.onSecondary,
                          size: 22.w,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
