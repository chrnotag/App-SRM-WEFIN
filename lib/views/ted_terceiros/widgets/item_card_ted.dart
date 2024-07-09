part of '../lista_teds_aprovacao_screen.dart';

class _ItemCardTed extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? cnpjFormatter;
  const _ItemCardTed({super.key, required this.title, this.content, this.cnpjFormatter});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.bodyMedium,),
        cnpjFormatter != null ? cnpjFormatter! : Text(
          content!,
          style: context.textTheme.bodyLarge!.copyWith(
              color: context.labelTextColor, fontWeight: FontWeight.w900),
        )
      ],
    );
  }
}
