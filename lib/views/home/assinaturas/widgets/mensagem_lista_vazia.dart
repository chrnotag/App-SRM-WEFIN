import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/extensions/screen_util_extension.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';

class MensagemListaVazia extends StatelessWidget {
  final String mensagem;
  final IconData icon;

  const MensagemListaVazia({super.key, required this.mensagem, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.r))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 64.h),
                    child: Container(
                      child: Icon(
                        icon,
                        color: context.primaryColor,
                        size: 200.r,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.h),
                    child: Text(
                      mensagem,
                      style: context.textTheme.bodyLarge!
                          .copyWith(color: context.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
