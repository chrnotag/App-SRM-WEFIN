import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/utils/pdf_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../core/providers/conta_digital/extrato/extrato_provider.dart';
import '../../../widgets/loader_widget.dart';

class TelaVisualizarPdfExtrato extends StatefulWidget {
  const TelaVisualizarPdfExtrato(
      {super.key});

  @override
  State<TelaVisualizarPdfExtrato> createState() =>
      _TelaVisualizarPdfExtratoState();
}

class _TelaVisualizarPdfExtratoState extends State<TelaVisualizarPdfExtrato> {
  @override
  void initState() {
    super.initState();
    final extratoProvider = Modular.get<ExtratoProvider>();
    extratoProvider.baixarDados();
  }

  @override
  Widget build(BuildContext context) {
    final extratoProvider = context.watch<ExtratoProvider>();
    return Scaffold(
      backgroundColor: Color(0xffd6d6d6),
      appBar: AppBar(
        backgroundColor: context.secondaryColor,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text('Extrato', style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.r), bottomRight: Radius.circular(12.r))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final DateFormat dateFormat = DateFormat("MM-yyyy");
          String name = "extrato_conta_digital_${dateFormat.format(extratoProvider.dataFinal())}";

          PDFUtils.sharePDF(extratoProvider.extratoDownloadBites!, name);
        },
        child: Icon(Icons.share, color: Colors.white),
        backgroundColor: SRMColors.secondaryColor,
      ),
      body: FutureBuilder(
          future: extratoProvider.downloadExtratoFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            if (snapshot.hasError) {
              print('erro ao exibir');
            }
            return SfPdfViewer.memory(extratoProvider.extratoDownloadBites!);
          }),
    );
  }
}
