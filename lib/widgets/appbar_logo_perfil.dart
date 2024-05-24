import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/deslogar/deslogar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Srm_Asset/core/constants/AppSizes.dart';
import '../core/constants/classes_abstratas/envirioment.dart';
import '../core/constants/route_labels.dart';
import '../core/providers/auth_provider_config/logar/auth_providers.dart';
import '../generated/assets.dart';
import '../models/auth_login_models/SRM/cedente_model.dart';

class AppBarLogo extends StatefulWidget {
  const AppBarLogo({Key? key}) : super(key: key);

  @override
  _AppBarLogoState createState() => _AppBarLogoState();
}

class _AppBarLogoState extends State<AppBarLogo> {
  late String _valorSelecionado;
  List<CedenteModel> _listaItens = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = context.watch<AuthProvider>();
    _valorSelecionado = authProvider.empresaSelecionada!.identificador;
    _listaItens = authProvider.listaCedente!;
  }

  @override
  Widget build(BuildContext context) {
    Environment ambiente = Modular.get<Environment>();
    final authProvider = context.watch<AuthProvider>();
    return AppBar(
      backgroundColor: SRMColors.secondaryColor,
      shadowColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
              child: SvgPicture.asset(ambiente.logoAppBar, width: 20.w),
              onTap: () => Modular.to.pushNamed(AppRoutes.menuAppRoute),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          Padding(
            padding: EdgeInsets.only(left: AppSizes.paddingMedium),
            child: Container(
              width: context.width * 0.7,
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
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
                  await authProvider.RelogarTrocarCedente(value!, context);
                },
                underline: Container(),
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              DeslogarUsuario(context: context).encerrarSessao();
            },
            icon: SvgPicture.asset(Assets.exit_icone, width: 29),
          )
        ],
      ),
    );
  }
}
