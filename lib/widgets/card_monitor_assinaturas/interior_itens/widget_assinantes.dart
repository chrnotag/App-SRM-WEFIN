part of '../card_monitor_assinaturas.dart';

class _WidgetAssinante extends StatelessWidget {
  final InformacaoAssinante infoAssinante;
  final String nomeAssinante;

  const _WidgetAssinante(
      {super.key, required this.infoAssinante, required this.nomeAssinante});

  Color corAssinatura() {
    if (infoAssinante.dataAssinatura != null) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.65,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              nomeAssinante.length > 16
                  ? '${nomeAssinante.substring(0, 20)}...'
                  : nomeAssinante,
              style: context.textTheme.bodyLarge!.copyWith(
                  color: Color(0XFF838383), fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.check_circle,
              color: corAssinatura(),
            )
          ],
        ),
      ),
    );
  }
}
