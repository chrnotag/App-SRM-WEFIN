part of 'card_monitor_operacoes.dart';

class _ComponentCardOperacoes extends StatelessWidget {
  final String title;
  final String label;
  final TextStyle? textStyle;

  const _ComponentCardOperacoes(
      {super.key, required this.title, required this.label, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium!
                .copyWith(color: AppColors.globalBackground),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            label,
            style: textStyle ??
                context.textTheme.bodySmall!
                    .copyWith(color: AppColors.labelText, fontSize: 10),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
