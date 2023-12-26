import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';

import '../core/constants/enuns/theme_enum.dart';
import '../core/providers/theme_provider.dart';

class TransparentAppBarEmpty extends StatelessWidget {
  const TransparentAppBarEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    bool isTemaSRM = themeProvider.temaSelecionado == TemaSelecionado.SRM;
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      iconTheme: IconThemeData(color: isTemaSRM ? Colors.white : context.primaryColor),
    );
  }
}
