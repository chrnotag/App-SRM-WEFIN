import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/enuns/import_certificado_enum.dart';
import 'package:modular_study/core/constants/extensions/screen_util_extension.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificado_provider.dart';
import 'package:modular_study/views/home/importar_certificado/pagina_carrossel_qrcode.dart';
import 'package:modular_study/views/home/importar_certificado/pagina_importar_certificado.dart';
import 'package:modular_study/widgets/transparent_appbar_empty.dart';

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
                        ? PaginaImportarCertificado.pagina(context)
                        : PaginaQrCodeCarrossel.pagina(context),
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
                      slideIndicator: CircularSlideIndicator(
                          padding: EdgeInsets.only(bottom: 30.h),
                          indicatorBorderColor:
                          Colors.grey.shade500.withAlpha(50),
                          currentIndicatorColor: context.primaryColor,
                          indicatorBackgroundColor:
                          context.primaryColor.withAlpha(80)),
                      showIndicator: true,
                    )),
              ),
            ],
          ),
          Positioned(
              bottom: 16.h,
              right: 16.w,
              child: Visibility(
                visible:
                    _paginaAtual < PaginaImportarCertificado.pagina(context).length - 1,
                child: FloatingActionButton(
                  onPressed: () {
                    _carrousselControler.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear);
                  },
                  backgroundColor: context.primaryColor,
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
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                backgroundColor: context.primaryColor,
                mini: true,
                child: const Icon(Icons.arrow_back),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
