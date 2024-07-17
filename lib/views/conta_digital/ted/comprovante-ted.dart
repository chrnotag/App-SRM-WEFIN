import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/conta_digital/comprovante_ted/comprovante_ted_provider.dart';
import 'package:Srm_Asset/core/utils/pdf_manager.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ComprovanteTed extends StatefulWidget {
  final String codigoTransacao;
  final String dataComprovante;

  const ComprovanteTed(
      {super.key,
      required this.codigoTransacao,
      required this.dataComprovante});

  @override
  State<ComprovanteTed> createState() => _ComprovanteTedState();
}

class _ComprovanteTedState extends State<ComprovanteTed> {
  @override
  void initState() {
    super.initState();
    final comprovanteTedProvider = Modular.get<ComprovanteTEDProvider>();
    comprovanteTedProvider.carregarDados(widget.codigoTransacao);
  }

  String montarNomeDocumento() {
    DateTime dataComprovante = DateTime.parse(widget.dataComprovante);
    DateFormat format = DateFormat('dd-MM-yyyy_HH-mm');
    String dataDocumento = format.format(dataComprovante);
    return 'comprovante_ted_$dataDocumento';
  }

  @override
  Widget build(BuildContext context) {
    final comprovanteTedProvider = context.watch<ComprovanteTEDProvider>();
    return Scaffold(
      backgroundColor: Color(0xffd6d6d6),
      appBar: AppBar(
        title: Text(
          'Comprovante de Transferência',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: context.secondaryColor,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.r), bottomLeft: Radius.circular(12.r))),
      ),
      body: FutureBuilder(
        future: comprovanteTedProvider.comprovanteTEDFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }
          return Stack(
            children: [
              SfPdfViewer.memory(
                  comprovanteTedProvider.comprovanteTEDDownloadBites!),
              Positioned(
                  bottom: 16,
                  left: context.width * 0.18,
                  child: BotaoPadrao(
                      label: 'Compartilhar Comprovante',
                      onPressed: () {
                        PDFUtils.sharePDF(
                            comprovanteTedProvider.comprovanteTEDDownloadBites!,
                            montarNomeDocumento());
                      }))
            ],
          );
        },
      ),
    );
  }
}
