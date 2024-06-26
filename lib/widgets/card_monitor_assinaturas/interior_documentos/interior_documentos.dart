part of '../card_monitor_assinaturas.dart';

class _InteriorDocumentosLista extends StatelessWidget {
  final MonitorAssinaturasModel assinaturasModel;

  const _InteriorDocumentosLista({super.key, required this.assinaturasModel});

  List<Widget> buildListaDocumentos() {
    final authProvider = Modular.get<AuthProvider>();
    List<Widget> listaDocumentos = [];
    for (var assinante in assinaturasModel.assinantes) {
      for (var infoAssinante in assinante.informacoesAssinante) {
        if (infoAssinante.identificadorAssinador ==
            authProvider.dataUser!.identificadorUsuario) {
          for (var documento in infoAssinante.documentos!) {
            listaDocumentos
                .add(_WidgetDocumentos(documento: documento));
          }
        }
      }
    }
    return listaDocumentos;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: _ItemListaDocumentos(
          titulo: "Documentos", conteudo: buildListaDocumentos()),
    );
  }
}
