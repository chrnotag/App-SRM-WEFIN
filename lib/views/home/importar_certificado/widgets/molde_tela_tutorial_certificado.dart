import 'package:Srm_Asset/core/constants/AppSizes.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/certificado_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/providers/certificado_provider/baixar_certificado_impl.dart';
import '../../../../widgets/dialog_senha_certificado.dart';

class MoldeTutorialCertificado extends StatelessWidget {
  final String imagemSvg;
  final String tituloPagina;
  final String? descricaoPagina;
  final Widget? richTextDescPagina;
  final bool isTelaFinal;
  final bool isQrCode;

  const MoldeTutorialCertificado(
      {super.key,
      required this.imagemSvg,
      required this.tituloPagina,
      this.descricaoPagina,
      this.isTelaFinal = false,
      this.isQrCode = false,
      this.richTextDescPagina});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 250.w,
            height: 300.h,
            child: SvgPicture.asset(imagemSvg),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.paddingLarge),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      tituloPagina,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingSmall),
                    child: richTextDescPagina ??
                        Text(
                          descricaoPagina!,
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isTelaFinal,
            child: SizedBox(
              width: context.width * 0.8,
              child: ElevatedButton(
                  onPressed: isQrCode
                      ? () async {
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
                      : () async {
                          final provider = Modular.get<CertificadoProvider>();
                          bool isPegouCertificado =
                              await provider.selecionarArquivoCertificado();
                          if (isPegouCertificado) {
                            await showDialog(
                                context: context,
                                builder: (context) => DialogSenhaCertificado());
                          }
                        },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      backgroundColor: context.focusColor),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingMedium),
                    child: Text(
                      'Importar Certificado',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
          ),
        ]);
  }
}
