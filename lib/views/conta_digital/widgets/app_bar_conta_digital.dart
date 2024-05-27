import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
class AppBarExtrato extends StatelessWidget {
  const AppBarExtrato({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.secondaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
      title: Text('Extrato', style: context.textTheme.displaySmall!.copyWith(color: Colors.white),),
      centerTitle: true,
    );
  }
}
