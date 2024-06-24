part of '../lista_ted_screen/lista_teds_aprovacao_screen.dart';

class _ItemCardTed extends StatelessWidget {
  final String title;
  final String content;

  const _ItemCardTed({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.bodyMedium,),
        Text(
          content,
          style: context.textTheme.bodyLarge!.copyWith(
              color: context.labelTextColor, fontWeight: FontWeight.w900),
        )
      ],
    );
  }
}
