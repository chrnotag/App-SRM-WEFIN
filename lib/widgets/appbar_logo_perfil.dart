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
import '../core/constants/tema_configs.dart';
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
  late CedenteModel _empresaSelecionada;
  late List<DropdownMenuItem<String>> itensDropDown;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = context.watch<AuthProvider>();
    _empresaSelecionada = authProvider.empresaSelecionada!;
    _valorSelecionado = _empresaSelecionada.nome;
    itensDropDown = List.of(authProvider.listaCedente!.map((e) =>
        DropdownMenuItem(
            value: e.nome,
            child: Text(e.nome,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium!
                    .copyWith(color: Colors.black)))));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    Environment ambiente = Modular.get<Environment>();

    return AppBar(
      backgroundColor: context.indicatorColor,
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
                menuMaxHeight: 300.h,
                dropdownColor: Colors.white,
                selectedItemBuilder: (context) {
                  return [Center(child: Text('Olá, ${_empresaSelecionada.nome}', maxLines: 1,overflow: TextOverflow.ellipsis,))];
                },
                isExpanded: true,
                value: _valorSelecionado,
                items: itensDropDown,
                onChanged: (value) async {
                  setState(() {
                    _valorSelecionado = value ?? "";
                    _empresaSelecionada = authProvider.listaCedente!
                        .firstWhere((item) => item.nome == _valorSelecionado);
                    itensDropDown = List.of(
                        authProvider.listaCedente!.map((e) => DropdownMenuItem(
                              value: e.nome,
                              child: Text(e.nome,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(color: Colors.black)),
                            )));
                    itensDropDown
                        .removeWhere((item) => item.value == _valorSelecionado);
                    itensDropDown.insert(
                        0,
                        DropdownMenuItem(
                            value: _valorSelecionado,
                            child: Text(
                              _valorSelecionado,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: Colors.black),
                            )));
                  });
                  await authProvider.RelogarTrocarCedente(
                      _empresaSelecionada.identificador, context);
                  authProvider.empresaSelecionada = _empresaSelecionada;
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
            onPressed: () {DeslogarUsuario(context: context).encerrarSessao();},
            icon: SvgPicture.asset(Assets.exit_icone, width: 29),
          )
        ],
      ),
    );
  }
}
