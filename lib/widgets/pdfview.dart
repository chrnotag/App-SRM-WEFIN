import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/documentos_provider/baixar_documentos_impl.dart';
import 'package:modular_study/core/utils/overlay.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  final String? url;
  final Documento? documento;

  const PdfView({
    super.key,
    this.url,
    this.documento,
  });

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        if (widget.documento != null)
          InkWell(
            onTap: () async {
              OverlayApp.iniciaOverlay(context);
              await BaixarDocumentosImpl(
                      documento: widget.documento!, isVisualizar: false)
                  .baixar();
              OverlayApp.terminaOverlay();
            },
            child: Icon(
              Icons.download,
              color: Colors.white,
            ),
          )
      ]),
      body: Container(
        child: SfPdfViewer.network(widget.url!),
      ),
    );
  }
}
