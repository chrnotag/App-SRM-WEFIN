part of '../card_monitor_assinaturas.dart';

class _InteriorProcuradores extends StatefulWidget {
  final MonitorAssinaturasModel assinatura;

  const _InteriorProcuradores({super.key, required this.assinatura});

  @override
  State<_InteriorProcuradores> createState() => _InteriorProcuradoresState();
}

class _InteriorProcuradoresState extends State<_InteriorProcuradores> {
  List<Widget> buildListaProcuradores() {
    final assinaturaProvider = Modular.get<AssinaturaProvider>();
    List<Widget> listaAssinantes = [];
    print('id do megapesados: ${Modular.get<AuthProvider>().empresaSelecionada!.identificador}');
    for (var assinante in widget.assinatura.assinantes) {
      for (var infoAssinante in assinante.informacoesAssinante) {
        if(infoAssinante.nomeProcurador != null){
          listaAssinantes.add(_WidgetItemProcuradores(nomeProcurador: infoAssinante.nomeProcurador,));
        }
      }
    }
    if(listaAssinantes.isEmpty){
      assinaturaProvider.existemProcuradores = false;
    }else{
      assinaturaProvider.existemProcuradores = true;
    }
    return listaAssinantes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: buildListaProcuradores().isNotEmpty,
          child: _ItemListaInterior(
              titulo: "Procuradores", conteudo: buildListaProcuradores()),
        )
      ],
    );
  }
}