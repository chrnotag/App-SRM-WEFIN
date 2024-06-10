part of '../card_monitor_assinaturas.dart';

class _InteriorAssinantes extends StatefulWidget {
  final MonitorAssinaturasModel assinatura;

  const _InteriorAssinantes({super.key, required this.assinatura});

  @override
  State<_InteriorAssinantes> createState() => _InteriorAssinantesState();
}

class _InteriorAssinantesState extends State<_InteriorAssinantes> {
  List<Widget> buildListaAssinantes() {
    List<Widget> listaAssinantes = [];
    for (var assinante in widget.assinatura.assinantes) {
      for (var infoAssinante in assinante.informacoesAssinante) {
        listaAssinantes.add(_WidgetAssinante(
            infoAssinante: infoAssinante,
            nomeAssinante: assinante.nomeAssinante.capitalizeCadaPalavra()));
      }
    }
    return listaAssinantes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ItemListaInterior(
            titulo: "Assinantes", conteudo: buildListaAssinantes())
      ],
    );
  }
}
