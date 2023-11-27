import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/enuns/import_certificado_enum.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificadode.dart';
import 'package:modular_study/views/home/importar_certificado/leitor_qrcode.dart';
import 'package:modular_study/widgets/dialog_senha_certificado.dart';
import 'package:modular_study/widgets/transparent_appbar_empty.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/themes/theme_configs.dart';

class GuiaImportCertificado extends StatefulWidget {
  const GuiaImportCertificado({super.key});

  @override
  State<GuiaImportCertificado> createState() => _GuiaImportCertificadoState();
}

class _GuiaImportCertificadoState extends State<GuiaImportCertificado> {
  CarouselController _carrousselControler = CarouselController();
  int _paginaAtual = 0;
  var viaImport = Modular.args.data;
  ImportarCertificadoProvider provider =
      Modular.get<ImportarCertificadoProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: const TransparentAppBarEmpty()),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: FlutterCarousel(
                    items: viaImport == ImportarVia.Dispositivo
                        ? _paginasCarrosselDispositivo()
                        : _paginaCarrousselQrCode(),
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      disableCenter: true,
                      controller: _carrousselControler,
                      initialPage: 0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _paginaAtual = index;
                        });
                      },
                      floatingIndicator: true,
                      showIndicator: true,
                    )),
              ),
            ],
          ),
          Positioned(
              bottom: 16,
              right: 16,
              child: Visibility(
                visible:
                    _paginaAtual < _paginasCarrosselDispositivo().length - 1,
                child: FloatingActionButton(
                  onPressed: () {
                    _carrousselControler.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear);
                  },
                  backgroundColor: AppColors.botaoEnvio,
                  mini: true,
                  child: const Icon(Icons.arrow_forward),
                ),
              )),
          Positioned(
            bottom: 16,
            left: 16,
            child: Visibility(
              visible: _paginaAtual > 0,
              child: FloatingActionButton(
                onPressed: () {
                  _carrousselControler.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                backgroundColor: AppColors.botaoEnvio,
                mini: true,
                child: const Icon(Icons.arrow_back),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _paginasCarrosselDispositivo() {
    return [
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Importe seu certificado digital',
              style: context.textTheme.displaySmall!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            Container(
              width: 250,
              height: 300,
              child: const Icon(
                Icons.archive_rounded,
                size: 150,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 300,
              child: Text(
                'Bem-vindo ao assistente de importação de certificado digital. Nas proximas páginas será explicado como importar seu arquivo de certificado digital de seu aparelho móvel.',
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Selecione seu Certificado',
              style: context.textTheme.displaySmall!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            Container(
              width: 250,
              height: 300,
              child: Placeholder(color: Colors.white),
            ),
            SizedBox(
              width: 300,
              child: Text(
                'Após clicar no botão de importação, seu explorador de arquivos será aberto. Navegue até a localização do seu certificado digital.',
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Localize seu Certificado',
              style: context.textTheme.displaySmall!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            Container(
              width: 250,
              height: 300,
              child: Placeholder(color: Colors.white),
            ),
            SizedBox(
              width: 300,
              child: Text(
                'Procure na lista de arquivos pelo seu certificado digital. Ele pode estar no formato .pfx, .p12, ou outro dependendo do seu dispositivo.',
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Selecionando o Certificado',
              style: context.textTheme.displaySmall!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            Container(
              width: 250,
              height: 300,
              child: Placeholder(color: Colors.white),
            ),
            SizedBox(
              width: 300,
              child: Text(
                'Uma vez que encontrar o arquivo do certificado, clique sobre ele para selecioná-lo. Será necessário informar a senha do certificado após isso',
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Importação Concluída',
              style: context.textTheme.displaySmall!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            Container(
              width: 250,
              height: 300,
              child: Placeholder(color: Colors.white),
            ),
            SizedBox(
              width: 300,
              child: Text(
                'Após selecionar o arquivo, o certificado será importado automaticamente. Basta informar a senha e você estará pronto para utilizá-lo!',
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await provider.selecionarArquivoCertificado();
                  showDialog(context: context, builder: (context) => DialogSenhaCertificado());
                },
                child: const Text('Importar Certificado'))
          ]),
    ];
  }

  List<Widget> _paginaCarrousselQrCode() {
    return [
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Importe seu certificado digital via QR Code',
              style: context.textTheme.displaySmall!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            const Icon(
              Icons.qr_code_2_rounded,
              size: 150,
              color: Colors.white,
            ),
            SizedBox(
              width: 300,
              child: Text(
                'Bem-vindo ao assistente de importação de certificado digital via QR Code. Nas próximas páginas, explicaremos como escanear o QR Code gerado no site para importar seu certificado digital.',
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Faça o Upload do Seu Certificado',
              style: context.textTheme.displaySmall!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            Container(
              width: 250,
              height: 300,
              child: Placeholder(color: Colors.white),
            ),
            SizedBox(
              width: 300,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Acesse ',
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                      text: 'nosso site',
                      style: const TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          const String url = "https://google.com";
                          await Share.share(url);
                        }),
                  TextSpan(
                    text:
                        ' no seu computador e faça o upload do seu certificado digital. Após o upload, um QR Code será gerado na tela para importação no aplicativo.',
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ]),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Escanear QR Code',
              style: context.textTheme.displaySmall!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            Container(
              width: 250,
              height: 300,
              child: Placeholder(color: Colors.white),
            ),
            SizedBox(
              width: 300,
              child: Text(
                'No aplicativo, use a opção de escanear QR Code para ler o código gerado no site. Isso irá capturar as informações necessárias do seu certificado.',
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Informe a Senha do Certificado',
              style: context.textTheme.displaySmall!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            Container(
              width: 250,
              height: 300,
              child: Placeholder(color: Colors.white),
            ),
            SizedBox(
              width: 300,
              child: Text(
                'Após escanear o QR Code, será solicitado que você insira a senha do seu certificado digital para concluir a importação.',
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Importação Concluída',
              style: context.textTheme.displaySmall!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            Container(
              width: 250,
              height: 300,
              child: Placeholder(color: Colors.white),
            ),
            SizedBox(
              width: 300,
              child: Text(
                'Seu certificado foi importado com sucesso! Agora você pode utilizar todas as funcionalidades do aplicativo com seu certificado digital.',
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeitorQrCode(),
                      ));
                },
                child: const Text('Ler QrCode'))
          ]),
    ];
  }
}
