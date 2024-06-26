part of '../card_monitor_assinaturas.dart';

class _WidgetDocumentos extends StatelessWidget {
  final Documento documento;

  const _WidgetDocumentos({super.key, required this.documento});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final documentoProvider = Modular.get<BaixarDocumentosProvider>();
        await BaixarDocumentosImpl(documento: documento).ler();
        if (documentoProvider.urlDocumento != null) {
          Modular.to.push(MaterialPageRoute(
            builder: (context) => PdfView(
              url: Modular.get<BaixarDocumentosProvider>().urlDocumento,
            ),
          ));
        } else {
          Fluttertoast.showToast(msg: 'O documento não pode ser apresentado no momento.');
        }
      },
      child: SizedBox(
        width: context.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(Assets.imagesIconePdf, color: Colors.green),
            Text(
              documento.nome!.length > 20
                  ? "${documento.nome!.substring(0, 20)}..."
                  : documento.nome!,
              style: context.textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
