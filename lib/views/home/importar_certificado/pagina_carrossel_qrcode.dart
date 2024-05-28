import 'dart:io';

import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/generated/assets.dart';
import 'package:Srm_Asset/views/home/importar_certificado/widgets/molde_tela_tutorial_certificado.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:share_plus/share_plus.dart';

class PaginaQrCodeCarrossel {
  static List<Widget> pagina(BuildContext context) {
    Environment ambiente = Modular.get<Environment>();
    return [
       MoldeTutorialCertificado(
        imagemSvg: context.imagensGuiaCertificado.primeiroSlideQrCode,
        tituloPagina: 'Importe seu certificado digital via QR Code',
        descricaoPagina:
            'Bem-vindo ao assistente de importação de certificado digital via QR Code. Nas próximas páginas, explicaremos como escanear o QR Code gerado no site para importar seu certificado digital.',
      ),
      MoldeTutorialCertificado(
          imagemSvg: context.imagensGuiaCertificado.segundoSlideQrCode,
          tituloPagina: 'Faça o Upload do Seu Certificado',
          richTextDescPagina: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Acesse ',
                style: context.textTheme.bodyMedium,
              ),
              TextSpan(
                  text: 'nosso site',
                  style: context.textTheme.bodyMedium!.copyWith(
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
                style: context.textTheme.bodyMedium,
              ),
            ]),
            textAlign: TextAlign.center,
          )),
      MoldeTutorialCertificado(
        imagemSvg: context.imagensGuiaCertificado.terceiroSlideQrCode,
        tituloPagina: 'Escanear Qr Code',
        descricaoPagina:
            'No aplicativo, use a opção de escanear QR Code para ler o código gerado no site. Isso irá capturar as informações necessárias do seu certificado.',
      ),
      MoldeTutorialCertificado(
        imagemSvg: context.imagensGuiaCertificado.quartoSlideQrCode,
        tituloPagina: 'Informe a senha do certificado',
        descricaoPagina:
            'Após escanear o QR Code, será solicitado que você insira a senha do seu certificado digital para concluir a importação.',
      ),
      MoldeTutorialCertificado(
        imagemSvg: context.imagensGuiaCertificado.quintoSlideQrCode,
        tituloPagina: 'Importação Concluída',
        descricaoPagina:
            'Seu certificado foi importado com sucesso! Agora você pode utilizar todas as funcionalidades do aplicativo com seu certificado digital.',
        isTelaFinal: true,
        isQrCode: true,
      )
    ];
  }
}
