part of 'card_monitor_assinaturas.dart';

class _ItemTextCard extends StatelessWidget {
  final String titulo;
  final String conteudo;
  const _ItemTextCard({super.key, required this.titulo, required this.conteudo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: context.textTheme.bodyMedium,
        ),
        Text(
          conteudo,
          style: context.textTheme.bodyLarge!.copyWith(
              color: Color(0XFF838383),
              fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
