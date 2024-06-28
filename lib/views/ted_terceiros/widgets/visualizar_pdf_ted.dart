part of 'botao_comprovante.dart';

class _VisualizarPdfTed extends StatefulWidget {
  const _VisualizarPdfTed({super.key});

  @override
  State<_VisualizarPdfTed> createState() => _VisualizarPdfTedState();
}

class _VisualizarPdfTedState extends State<_VisualizarPdfTed> {
  @override
  Widget build(BuildContext context) {
    final provider = Modular.get<TedTerceirosProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Comprovante'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: Image.asset(
            AssetsConfig.imagesIconePdf,
            color: Colors.white,
          ),
          backgroundColor: context.primaryColor,
          onPressed: () {
            PDFUtils.sharePDF(provider.pdfComprovante!, 'Comprovante');
          }),
      body: SfPdfViewer.memory(provider.pdfComprovante!),
    );
  }
}
