import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/enuns/import_certificado_enum.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/widgets/transparent_appbar_empty.dart';

import '../../../core/constants/themes/theme_configs.dart';

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
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Escolha a forma desejada para importar o certificado.',
                  style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'QRCode: ',
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      children: [
                        TextSpan(
                          text:
                              'Selecione essa opção para importar via QRCode usando o nosso site para gerar o QRCode',
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
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
                        fontWeight: FontWeight.bold, color: Colors.white),
                    children: [
                      TextSpan(
                        text:
                            'Selecione essa opção para importar o certificado diretamente de seu dispositivo.',
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal, color: Colors.white),
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
                  child: ElevatedButton(
                    onPressed: () {
                      Modular.to.pushNamed(
                          AppRoutes.guiaImportarCertificadoRoute,
                          arguments: {ImportarVia.QrCode});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.botaoEnvio,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.qr_code_2,
                            color: Colors.white,
                            size: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Importar via QRCode',
                              style: context.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Modular.to.pushNamed(AppRoutes.guiaImportarCertificadoRoute,
                        arguments: ImportarVia.Dispositivo);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.globalBackground,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(color: Colors.white, width: 2)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.archive_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Importar do dispositivo',
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
