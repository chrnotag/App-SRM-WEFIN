import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/widgets/transparent_appbar_empty.dart';

class GuiaImportDispositivo extends StatefulWidget {
  const GuiaImportDispositivo({super.key});

  @override
  State<GuiaImportDispositivo> createState() => _GuiaImportDispositivoState();
}

class _GuiaImportDispositivoState extends State<GuiaImportDispositivo> {
  @override
  Widget build(BuildContext context) {
    final CarouselController _carrousselControler = CarouselController();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: const TransparentAppBarEmpty()),
      body: Column(
        children: [
          Expanded(
            child: FlutterCarousel(items: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  'Importe seu certificado digital',
                  style: context.textTheme.displaySmall!
                      .copyWith(color: Colors.white, fontSize: 22),
                ),
                Container(width: 250, height: 300,
                child: Placeholder(color: Colors.white),),
                Text('Bem-vindo ao assistente de importação de certificado digital. Clique no botão abaixo para começar.'),
                ElevatedButton(onPressed: (){}, child: Text('Começar'))
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  'Importe seu certificado digital',
                  style: context.textTheme.displaySmall!
                      .copyWith(color: Colors.white, fontSize: 22),
                ),
                Container(width: 250, height: 300,
                child: Placeholder(color: Colors.white),),
                Text('Bem-vindo ao assistente de importação de certificado digital. Clique no botão abaixo para começar.'),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  'Importe seu certificado digital',
                  style: context.textTheme.displaySmall!
                      .copyWith(color: Colors.white, fontSize: 22),
                ),
                Container(width: 250, height: 300,
                child: Placeholder(color: Colors.white),),
                Text('Bem-vindo ao assistente de importação de certificado digital. Clique no botão abaixo para começar.'),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  'Importe seu certificado digital',
                  style: context.textTheme.displaySmall!
                      .copyWith(color: Colors.white, fontSize: 22),
                ),
                Container(width: 250, height: 300,
                child: Placeholder(color: Colors.white),),
                Text('Bem-vindo ao assistente de importação de certificado digital. Clique no botão abaixo para começar.'),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  'Importe seu certificado digital',
                  style: context.textTheme.displaySmall!
                      .copyWith(color: Colors.white, fontSize: 22),
                ),
                Container(width: 250, height: 300,
                child: Placeholder(color: Colors.white),),
                Text('Bem-vindo ao assistente de importação de certificado digital. Clique no botão abaixo para começar.'),
                ElevatedButton(onPressed: (){}, child: Text('Importar Certificado'))
              ]),
            ], options: CarouselOptions(
              controller: _carrousselControler,
              initialPage: 0,
              floatingIndicator: true,
              showIndicator: true,
            )),
          ),
        ],
      ),
    );
  }
}
