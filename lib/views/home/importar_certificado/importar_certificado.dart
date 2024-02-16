import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/enuns/import_certificado_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/widgets/transparent_appbar_empty.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';

import '../../../core/constants/enuns/theme_enum.dart';
import '../../../core/providers/theme_provider.dart';

class ImportarCertificado extends StatelessWidget {
  const ImportarCertificado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: TransparentAppBarEmpty()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Escolha a forma desejada para importar o certificado.',
                  style: context.textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'QRCode: ',
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.onSecondary),
                      children: [
                        TextSpan(
                          text:
                              'Selecione essa opção para importar via QRCode usando o nosso site para gerar o QRCode',
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: context.onSecondary),
                        )
                      ],
                    ),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Do dispositivo: ',
                    style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.onSecondary),
                    children: [
                      TextSpan(
                        text:
                            'Selecione essa opção para importar o certificado diretamente de seu dispositivo.',
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                            color: context.onSecondary),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: BotaoPadrao(
                      onPressed: () {
                        Modular.to.pushNamed(
                            AppRoutes.guiaImportarCertificadoRoute,
                            arguments: {ImportarVia.QrCode});
                      },
                      label: 'Importar Via QRCode',
                      icon: Icons.qr_code_2_rounded,
                    )),
                BotaoPadrao(
                  onPressed: () {
                    Modular.to.pushNamed(AppRoutes.guiaImportarCertificadoRoute,
                        arguments: ImportarVia.Dispositivo);
                  },
                  label: 'Importar Via Dispositivo',
                  filled: false,
                  icon: Icons.archive_rounded,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
