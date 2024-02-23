import 'package:Srm_Asset/core/constants/urls-uteis.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/endpoints.dart';
import '../../../widgets/wefin_patterns/wefin_default_button.dart';
import 'leitor_qrcode.dart';

class PaginaQrCodeCarrossel {
  static List<Widget> pagina(BuildContext context) {
    return [
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Importe seu certificado digital via QR Code',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge!
                  .copyWith(color: context.onSecondary),
            ),
            Icon(
              Icons.qr_code_2_rounded,
              size: 150.r,
              color: context.onSecondary,
            ),
            SizedBox(
              width: 300.w,
              child: Text(
                'Bem-vindo ao assistente de importação de certificado digital via QR Code. Nas próximas páginas, explicaremos como escanear o QR Code gerado no site para importar seu certificado digital.',
                style: context.textTheme.bodyLarge!
                    .copyWith(color: context.onSecondary),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Faça o Upload do Seu Certificado',
              style: context.textTheme.bodyLarge!
                  .copyWith(color: context.onSecondary),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 300.w,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Acesse ',
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: context.onSecondary),
                  ),
                  TextSpan(
                      text: 'nosso site',
                      style: context.textTheme.bodyLarge!.copyWith(
                          color: context.onSecondary,
                          decoration: TextDecoration.underline, fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          const String url = Urls.siteQrCode;
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
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Escanear QR Code',
              style: context.textTheme.bodyLarge!
                  .copyWith(color: context.onSecondary),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 300.w,
              child: Text(
                'No aplicativo, use a opção de escanear QR Code para ler o código gerado no site. Isso irá capturar as informações necessárias do seu certificado.',
                style: context.textTheme.bodyMedium!
                    .copyWith(color: context.onSecondary),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Informe a Senha do Certificado',
              style: context.textTheme.bodyLarge!
                  .copyWith(color: context.onSecondary),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 300.w,
              child: Text(
                'Após escanear o QR Code, será solicitado que você insira a senha do seu certificado digital para concluir a importação.',
                style: context.textTheme.bodyMedium!
                    .copyWith(color: context.onSecondary),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Importação Concluída',
              style: context.textTheme.bodyLarge!
                  .copyWith(color: context.onSecondary),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 300.w,
              child: Text(
                'Seu certificado foi importado com sucesso! Agora você pode utilizar todas as funcionalidades do aplicativo com seu certificado digital.',
                style: context.textTheme.bodyMedium!
                    .copyWith(color: context.onSecondary),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: context.width * 0.5,
              child: BotaoPadrao(
                  onPressed: () async {
                    Modular.to.pushNamed(AppRoutes.leitorQrCodeRoute);
                  },
                  label: 'Ler QrCode'),
            )
          ]),
    ];
  }
}
