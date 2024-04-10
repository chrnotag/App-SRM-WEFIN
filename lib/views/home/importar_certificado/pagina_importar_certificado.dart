import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';

import '../../../core/providers/certificado_provider/certificado_provider.dart';
import '../../../widgets/dialog_senha_certificado.dart';
import '../../../widgets/wefin_patterns/wefin_default_button.dart';

class PaginaImportarCertificado {
  static List<Widget> pagina(BuildContext context) {
    CertificadoProvider provider =
        Modular.get<CertificadoProvider>();
    return [
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Importe seu certificado digital',
              style: context.textTheme.bodyLarge!
                  .copyWith(color: context.onSecondary),
            ),
            Container(
              width: 250.w,
              height: 300.h,
              child: Icon(
                Icons.archive_rounded,
                size: 150.r,
                color: context.onSecondary,
              ),
            ),
            SizedBox(
              width: 300.w,
              child: Text(
                'Bem-vindo ao assistente de importação de certificado digital. Nas proximas páginas será explicado como importar seu arquivo de certificado digital de seu aparelho móvel.',
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
              'Selecione seu Certificado',
              style: context.textTheme.bodyLarge!
                  .copyWith(color: context.onSecondary),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 300.w,
              child: Text(
                'Após clicar no botão de importação, seu explorador de arquivos será aberto. Navegue até a localização do seu certificado digital.',
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
              'Localize seu Certificado',
              style: context.textTheme.bodyLarge!
                  .copyWith(color: context.onSecondary),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 300.w,
              child: Text(
                'Procure na lista de arquivos pelo seu certificado digital. Ele pode estar no formato .pfx, .p12, ou outro dependendo do seu dispositivo.',
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
              'Selecionando o Certificado',
              style: context.textTheme.bodyLarge!
                  .copyWith(color: context.onSecondary),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 300.w,
              child: Text(
                'Uma vez que encontrar o arquivo do certificado, clique sobre ele para selecioná-lo. Será necessário informar a senha do certificado após isso',
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
                'Após selecionar o arquivo, o certificado será importado automaticamente. Basta informar a senha e você estará pronto para utilizá-lo!',
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
                    bool isPegouCertificado =
                        await provider.selecionarArquivoCertificado();
                    if (isPegouCertificado) {
                      await showDialog(
                          context: context,
                          builder: (context) => DialogSenhaCertificado());
                    }
                  },
                  label: 'Importar Certificado'),
            )
          ]),
    ];
  }
}
