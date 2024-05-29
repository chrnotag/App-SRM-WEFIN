part of 'card_monitor_assinaturas.dart';

class _ItemListaInterior extends StatelessWidget {
  final String titulo;
  final List<Widget> conteudo;
  const _ItemListaInterior({super.key, required this.titulo, required this.conteudo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: context.textTheme.bodyMedium,
        ),
        ...conteudo
      ],
    );
  }
}
