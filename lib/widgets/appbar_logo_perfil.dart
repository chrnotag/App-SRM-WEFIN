import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/enuns/theme_enum.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/providers/theme_provider.dart';

import '../core/constants/themes/theme_configs.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    return AppBar(
      iconTheme: IconThemeData(color: AppColors.verdePrimarioTRUST),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: true,
      title: Image.asset(themeProvider.logoTema, width: 70),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: FloatingActionButton.small(
            onPressed: () => Modular.to.pushNamed(AppRoutes.menuAppRoute),
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(width: 1, color: context.onSecondary)),
            child: const Icon(Icons.perm_identity, size: 30),
          ),
        )
      ],
    );
  }
}
