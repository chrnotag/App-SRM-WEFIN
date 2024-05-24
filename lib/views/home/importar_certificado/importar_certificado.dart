import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/enuns/import_certificado_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:crosspki/crosspki.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import '../../../core/providers/certificado_provider/baixar_certificado_impl.dart';
import '../../../core/providers/certificado_provider/certificado_provider.dart';
import '../../../widgets/dialog_senha_certificado.dart';

class ImportarCertificado extends StatelessWidget {
  const ImportarCertificado({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> existeCertificadosImportados() async {
      final List<PKCertificate> certificadosImportados =
          await CrossPki.listCertificatesWithKey();
      return certificadosImportados.isEmpty;
    }

    CertificadoProvider provider = Modular.get<CertificadoProvider>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Modular.to.pop(),
              )
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Escolha a forma para\n importar o certificado.',
                  style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w900, color: Colors.black),
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
                          color: context.labelTextColor),
                      children: [
                        TextSpan(
                          text:
                              'Selecione essa opção para importar via QRCode usando o nosso site para gerar o QRCode',
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: context.labelTextColor),
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
                        color: context.labelTextColor),
                    children: [
                      TextSpan(
                        text:
                            'Selecione essa opção para importar o certificado diretamente de seu dispositivo.',
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                            color: context.labelTextColor),
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
                    child: SizedBox(
                      width: context.width * 0.7,
                      child: BotaoPadrao(
                        onPressed: () async {
                          final bool mostraGuiaImportacao =
                              await existeCertificadosImportados();
                          if (mostraGuiaImportacao) {
                            Modular.to.pop();
                            Modular.to.pushNamed(
                                AppRoutes.guiaImportarCertificadoRoute,
                                arguments: {ImportarVia.QrCode});
                          } else {
                            String barcodeScanRes;
                            try {
                              barcodeScanRes =
                                  await FlutterBarcodeScanner.scanBarcode(
                                '#ff6666',
                                'Cancelar',
                                true,
                                ScanMode.QR,
                              );
                              BaixarCertificadoImpl.baixar(barcodeScanRes);
                            } on Exception catch (_) {}
                          }
                        },
                        label: 'QR Code',
                        textStyleFilled: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    )),
                SizedBox(
                  width: context.width * 0.7,
                  child: BotaoPadrao(
                    onPressed: () async {
                      final bool mostraGuiaImportacao =
                          await existeCertificadosImportados();
                      if (mostraGuiaImportacao) {
                        Modular.to.pop();
                        Modular.to.pushNamed(
                            AppRoutes.guiaImportarCertificadoRoute,
                            arguments: ImportarVia.Dispositivo);
                      } else {
                        bool isPegouCertificado =
                            await provider.selecionarArquivoCertificado();
                        if (isPegouCertificado) {
                          await showDialog(
                              context: context,
                              builder: (context) => DialogSenhaCertificado());
                        }
                      }
                    },
                    label: 'Do dispositivo',
                    filled: false,
                    textStyleNoFilled: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w900, color: context.focusColor),
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
