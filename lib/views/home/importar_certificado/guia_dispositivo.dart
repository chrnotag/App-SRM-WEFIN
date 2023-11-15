import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/utils/importar_certificado.dart';
import 'package:modular_study/widgets/transparent_appbar_empty.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/constants/themes/theme_configs.dart';

class GuiaImportDispositivo extends StatefulWidget {
  const GuiaImportDispositivo({super.key});

  @override
  State<GuiaImportDispositivo> createState() => _GuiaImportDispositivoState();
}

class _GuiaImportDispositivoState extends State<GuiaImportDispositivo> {
  CarouselController _carrousselControler = CarouselController();
  int _paginaAtual = 0;
  TextEditingController _senhaCertificadoController = TextEditingController();

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
                    items: _paginasCarrossel(),
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
                          log('numero da pagina atual $_paginaAtual, index atual: $index, numero de paginas: ${_paginasCarrossel().length}');
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
                visible: _paginaAtual < _paginasCarrossel().length - 1,
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

  List<Widget> _paginasCarrossel() {
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
              child: Placeholder(color: Colors.white),
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
                'Uma vez que encontrar o arquivo do certificado, clique sobre ele para selecioná-lo.',
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
                'Após selecionar o arquivo, o certificado será importado automaticamente. Você está pronto para utilizá-lo!',
                style:
                    context.textTheme.bodyMedium!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  Uint8List? fileContent =
                      await ImportarCertificado.selecionarArquivoCertificado();
                  log("teste: ${fileContent!.length}");
                  if (fileContent.isNotEmpty) {
                    String senha = '';
                    _pedirSenhaCertificado(fileContent);
                  }
                },
                child: const Text('Importar Certificado'))
          ]),
    ];
  }

  void _pedirSenhaCertificado(Uint8List fileContent) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: TextField(
          controller: _senhaCertificadoController,
          decoration: const InputDecoration(
              hintText: 'Informe a senha do certificado',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1))),
        ),
        actions: [
          ElevatedButton(
              onPressed: () async {
                await ImportarCertificado.importarCertificado(
                    fileContent, _senhaCertificadoController.text);
                Modular.to.pop();
                Modular.to.pop();
              },
              child: Text('OK'))
        ],
      ),
    );
  }
}
