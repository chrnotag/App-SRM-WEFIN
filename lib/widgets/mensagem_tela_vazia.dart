import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/configs_tema/srm/colors.dart';

class MensagemTelaVazia extends StatelessWidget {
  final String titulo;
  final String mensagem;
  const MensagemTelaVazia({super.key, required this.titulo, required this.mensagem});
  @override
  Widget build(BuildContext context) {
  final ambiente = Modular.get<Environment>();
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(ambiente.alerta_icone),
            Padding(
              padding:
              EdgeInsets.symmetric(vertical: 50.h),
              child: Column(
                children: [
                  Text(
                    titulo,
                    style: context.textTheme
                        .displaySmall!
                        .copyWith(
                        color:
                        SRMColors.textBodyColor,
                        fontWeight:
                        FontWeight.w900),
                  ),
                  Text(
                    mensagem,
                    style: context.textTheme.bodyLarge!
                        .copyWith(
                        color: context
                            .labelTextColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
