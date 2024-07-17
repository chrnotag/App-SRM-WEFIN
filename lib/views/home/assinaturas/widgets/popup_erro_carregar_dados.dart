import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../core/constants/route_labels.dart';
import '../../../../widgets/wefin_patterns/wefin_default_button.dart';
class PopUpErroCarregarDados extends StatelessWidget {
  const PopUpErroCarregarDados({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        LineIcons.exclamationCircle,
        color: context.focusColor,
        size: 20.r,
      ),
      title: Column(
        children: [
          Text(
            "Erro ao carregar operações.",
            style: context.textTheme.labelMedium,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text("Tente novamente mais tarde."),
          ),
          BotaoPadrao(
              label: 'Ok',
              onPressed: () =>
                  Modular.to.navigate(AppRoutes.homeAppNavigatorRoute))
        ],
      ),
    );
  }
}
