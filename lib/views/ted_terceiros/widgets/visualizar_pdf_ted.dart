
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../assets_config/assets_config.dart';
import '../../../core/providers/ted_terceiros/ted_terceiros_provider.dart';
import '../../../core/utils/pdf_manager.dart';

class VisualizarPdfTed extends StatefulWidget {
  const VisualizarPdfTed({super.key});

  @override
  State<VisualizarPdfTed> createState() => _VisualizarPdfTedState();
}

class _VisualizarPdfTedState extends State<VisualizarPdfTed> {
  @override
  Widget build(BuildContext context) {
    final provider = Modular.get<TedTerceirosProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Comprovante'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: context.primaryColor,
          onPressed: () {
            PDFUtils.sharePDF(provider.pdfComprovante!, 'Comprovante');
          },
          child: Image.asset(
            AssetsConfig.imagesIconePdf,
            color: Colors.white,
          )),
      body: SfPdfViewer.memory(provider.pdfComprovante!),
    );
  }
}
