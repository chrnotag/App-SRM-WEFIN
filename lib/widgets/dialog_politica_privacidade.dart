import 'dart:developer';

import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/widgets/pdfview.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../core/constants/themes/theme_configs.dart';

class AlertPoliticaPrivacidade extends StatefulWidget {
  const AlertPoliticaPrivacidade({super.key});

  @override
  State<AlertPoliticaPrivacidade> createState() =>
      _AlertPoliticaPrivacidadeState();
}

class _AlertPoliticaPrivacidadeState extends State<AlertPoliticaPrivacidade> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Column(
      children: [
        Text(
          'Política de Privacidade',
          textAlign: TextAlign.center,
          style: context.textTheme.displaySmall,
        ),
        Container(
          height: context.height * 0.7,
          child: SfPdfViewer.network(
            'https://www.srmasset.com/wp-content/uploads/2021/08/SRM-Pol%C3%ADtica-de-Privacidade-e-Tratamento-de-Dados-Pessoais-01.07.2021.pdf',
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: isChecked,
              activeColor: context.primaryColor,
              onChanged: (value) => setState(() {
                isChecked = !isChecked;
              }),
            ),
            Text('Aceito os termos de uso e política de privacidade.')
          ],
        ),
        BotaoPadrao(
          label: 'Continuar',
          onPressed: isChecked ? () => aceitarPolitica(isChecked) : null,
        )
      ],
    ));
  }

  void aceitarPolitica(bool check) async {
    OverlayApp.iniciaOverlay(context);
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final bool? politica_aceita =
          await sharedPreferences.getBool('politica-aceita');
      if (politica_aceita == null || !politica_aceita) {
        await sharedPreferences.setBool('politica-aceita', check);
        OverlayApp.terminaOverlay();
        Modular.to.pop();
      }
    } catch (_) {
    }
  }
}
