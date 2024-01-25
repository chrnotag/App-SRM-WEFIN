
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/auth_provider_config/deslogar/deslogar_controller.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';

class ModalListDocuments {
  late BuildContext context;

  Widget get popUp {
    return AlertDialog(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Modular.to.pop();
                  },
                  icon: const Icon(LineIcons.times)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Atenção',
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  letterSpacing: 1.5,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Deseja encerrar o aplicativo?',
                style: context.textTheme.labelSmall!
                    .copyWith(color: AppColors.labelText)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: BotaoPadrao(
                    onPressed: () {
                      DeslogarUsuario().deslogar();
                    },
                    label: 'SAIR',
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: BotaoPadrao(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    label: 'CANCELAR',
                filled: false,),
              )
            ],
          )
        ],
      ),
    );
  }
}
