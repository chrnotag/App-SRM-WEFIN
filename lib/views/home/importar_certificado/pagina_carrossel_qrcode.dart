import 'dart:io';

import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/generated/assets.dart';
import 'package:Srm_Asset/widgets/molde_tela_tutorial_certificado.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../../core/providers/certificado_provider/baixar_certificado_impl.dart';
import '../../../widgets/wefin_patterns/wefin_default_button.dart';

class PaginaQrCodeCarrossel {
  static List<Widget> pagina(BuildContext context) {
    Environment ambiente = Modular.get<Environment>();
    return [
      const MoldeTutorialCertificado(
        imagemSvg: Assets.importe_certificado_svg,
        tituloPagina: 'Importe seu certificado digital via QR Code',
        descricaoPagina:
            'Bem-vindo ao assistente de importação de certificado digital via QR Code. Nas próximas páginas, explicaremos como escanear o QR Code gerado no site para importar seu certificado digital.',
      ),
      MoldeTutorialCertificado(
          imagemSvg: Assets.upload_certificado_svg,
          tituloPagina: 'Faça o Upload do Seu Certificado',
          richTextDescPagina: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Acesse ',
                style: context.textTheme.bodyMedium!
                    .copyWith(color: context.onSecondary),
              ),
              TextSpan(
                  text: 'nosso site',
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: context.onSecondary,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      fontWeight: FontWeight.w900),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final String url = ambiente.endpoints.siteQrCode;
                      await Share.share(url);
                    }),
              TextSpan(
                text:
                    ' no seu computador e faça o upload do seu certificado digital. Após o upload, um QR Code será gerado na tela para importação no aplicativo.',
                style: context.textTheme.bodyMedium!
                    .copyWith(color: context.onSecondary),
              ),
            ]),
            textAlign: TextAlign.center,
          )),
      const MoldeTutorialCertificado(
        imagemSvg: Assets.scanear_qrcode_svg,
        tituloPagina: 'Escanear Qr Code',
        descricaoPagina:
            'No aplicativo, use a opção de escanear QR Code para ler o código gerado no site. Isso irá capturar as informações necessárias do seu certificado.',
      ),
      const MoldeTutorialCertificado(
        imagemSvg: Assets.informe_senha_certificado_svg,
        tituloPagina: 'Informe a senha do certificado',
        descricaoPagina:
            'Após escanear o QR Code, será solicitado que você insira a senha do seu certificado digital para concluir a importação.',
      ),
      const MoldeTutorialCertificado(
        imagemSvg: Assets.importacao_concluida_svg,
        tituloPagina: 'Importação Concluída',
        descricaoPagina:
            'Seu certificado foi importado com sucesso! Agora você pode utilizar todas as funcionalidades do aplicativo com seu certificado digital.',
        isTelaFinal: true,
        isQrCode: true,
      )
    ];
  }
}
