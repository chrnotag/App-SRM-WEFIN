import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/providers/relatorio_titulos_provider/relatorio_titulos_provider.dart';
import 'package:Srm_Asset/core/utils/pdf_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfRelatorioView extends StatefulWidget {
  const PdfRelatorioView({super.key});

  @override
  State<PdfRelatorioView> createState() => _PdfRelatorioViewState();
}

class _PdfRelatorioViewState extends State<PdfRelatorioView> {
  final provider = Modular.get<RelatorioTitulosProvider>();
  @override
  void dispose() {
    super.dispose();
    provider.dadosPdfRelatorio = null;
    provider.dadosBoleto = null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => PDFUtils.sharePDF(provider.dadosPdfRelatorio ?? provider.dadosBoleto!, 'Relatório_Titulos_Trust'), child: Image.asset(AssetsConfig.imagesIconePdf, color: Colors.white,),),
      appBar: AppBar(),
      body: SfPdfViewer.memory(provider.dadosPdfRelatorio!),
    );
  }
}
