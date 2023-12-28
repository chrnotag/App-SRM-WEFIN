import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/enuns/import_certificado_enum.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/widgets/transparent_appbar_empty.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';

import '../../../core/constants/enuns/theme_enum.dart';
import '../../../core/providers/theme_provider.dart';

class ImportarCertificado extends StatelessWidget {
  const ImportarCertificado({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    bool isTemaSRM = themeProvider.temaSelecionado == TemaSelecionado.SRM;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: TransparentAppBarEmpty()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Escolha a forma desejada para importar o certificado.',
                  style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:isTemaSRM ? Colors.white : context.shadersTrust[900]),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'QRCode: ',
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold, color:isTemaSRM ? Colors.white : context.shadersTrust[900]),
                      children: [
                        TextSpan(
                          text:
                              'Selecione essa opção para importar via QRCode usando o nosso site para gerar o QRCode',
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              color:isTemaSRM ? Colors.white : context.shadersTrust[900]),
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
                        fontWeight: FontWeight.bold, color: isTemaSRM ? Colors.white : context.shadersTrust[900]),
                    children: [
                      TextSpan(
                        text:
                            'Selecione essa opção para importar o certificado diretamente de seu dispositivo.',
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal, color: isTemaSRM ? Colors.white : context.shadersTrust[900]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: WefinDefaultButton(
                    onPressed: () {
                      Modular.to.pushNamed(
                          AppRoutes.guiaImportarCertificadoRoute,
                          arguments: {ImportarVia.QrCode});
                    },
                    label: 'Importar Via QRCode',
                    fontSize: 14,
                    icon: Icons.qr_code_2_rounded,
                  )
                ),
                WefinDefaultButton(
                  onPressed: () {
                    Modular.to.pushNamed(AppRoutes.guiaImportarCertificadoRoute,
                        arguments: ImportarVia.Dispositivo);
                  },
                  label: 'Importar Via Dispositivo',
                  fontSize: 14,
                  filled: false,
                  labelColor: isTemaSRM ? Colors.white : null,
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
