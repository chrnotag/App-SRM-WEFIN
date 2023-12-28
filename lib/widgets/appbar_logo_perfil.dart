import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/enuns/theme_enum.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/providers/theme_provider.dart';

import '../core/constants/themes/theme_configs.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    bool isTemaSRM = themeProvider.temaSelecionado == TemaSelecionado.SRM;
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: UnderlineInputBorder(
          borderSide: BorderSide(color: isTemaSRM ? Colors.blue.shade900 : TrustShades.primaryColor[900]!, width: 0.5)),
      centerTitle: true,
      title: Image.asset(themeProvider.logoTema, width: 70),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: FloatingActionButton.small(
            onPressed: () =>  Modular.to.pushNamed(AppRoutes.menuAppRoute),
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(color: themeProvider.brancoOuVerde, width: 0.5)),
            child: Icon(Icons.perm_identity, size: 30, color: themeProvider.brancoOuVerde,),
          ),
        )
      ],
    );
  }
}
