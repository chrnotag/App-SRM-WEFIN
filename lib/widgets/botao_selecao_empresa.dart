import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modular_study/core/constants/enuns/theme_enum.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/providers/theme_provider.dart';

import '../generated/assets.dart';

class SelecaoEmpresa extends StatelessWidget {
  final String nomeEmpresa;
  final String tituloPagina;
  final bool changeble;

  const SelecaoEmpresa({
    super.key,
    required this.nomeEmpresa,
    this.tituloPagina = '',
    this.changeble = true,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Visibility(
            visible: tituloPagina.isNotEmpty,
            child: Text(
              tituloPagina,
              style: context.textTheme.bodyMedium!
                  .copyWith(color: themeProvider.temaSelecionado == TemaSelecionado.SRM ? Colors.white : context.shadersTrust[900]!, fontWeight: FontWeight.w100),
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: themeProvider.temaSelecionado == TemaSelecionado.SRM ? Colors.white : context.primaryColor, width: 0.5, strokeAlign: 1),
                  borderRadius: BorderRadius.circular(30)),
              child: InkWell(
                onTap: changeble
                    ? () =>
                        Modular.to.navigate(AppRoutes.listaSelecaoEmpresasRoute)
                    : () {},
                borderRadius: BorderRadius.circular(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          nomeEmpresa,
                          style: context.textTheme.bodySmall!
                              .copyWith(color: themeProvider.temaSelecionado == TemaSelecionado.SRM ? Colors.white : context.shadersTrust[900]),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: changeble,
                      child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(
                            Assets.iconsIcChangeCnpj,
                            color: themeProvider.temaSelecionado == TemaSelecionado.SRM ? Colors.white : context.shadersTrust[900],
                            width: 15,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
