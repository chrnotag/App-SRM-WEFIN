import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/tema_configs.dart';
class AppBarExtrato extends StatelessWidget {
  const AppBarExtrato({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.azul,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
      title: Text('Extrato', style: context.textTheme.displaySmall!.copyWith(color: Colors.white),),
      centerTitle: true,
    );
  }
}
