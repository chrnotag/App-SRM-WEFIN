import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/enuns/import_certificado_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/certificado_provider.dart';
import 'package:Srm_Asset/views/home/importar_certificado/pagina_carrossel_qrcode.dart';
import 'package:Srm_Asset/views/home/importar_certificado/pagina_importar_certificado.dart';
import 'package:Srm_Asset/widgets/transparent_appbar_empty.dart';

class GuiaImportCertificado extends StatefulWidget {
  const GuiaImportCertificado({super.key});

  @override
  State<GuiaImportCertificado> createState() => _GuiaImportCertificadoState();
}

class _GuiaImportCertificadoState extends State<GuiaImportCertificado> {
  CarouselController _carrousselControler = CarouselController();
  var viaImport = Modular.args.data;
  CertificadoProvider provider =
      Modular.get<CertificadoProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: const TransparentAppBarEmpty()),
      body: Column(
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
                  floatingIndicator: true,
                  slideIndicator: CircularSlideIndicator(
                      padding: EdgeInsets.only(bottom: 30.h),
                      indicatorBorderColor:
                      Colors.grey.shade500.withAlpha(50),
                      currentIndicatorColor: context.focusColor,
                      indicatorBackgroundColor:
                      context.primaryColor.withAlpha(80)),
                  showIndicator: true,
                )),
          ),
        ],
      ),
    );
  }
}
