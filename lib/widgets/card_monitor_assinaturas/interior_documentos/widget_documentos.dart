part of '../card_monitor_assinaturas.dart';

class _WidgetDocumentos extends StatelessWidget {
  final String nomeDocumento;

  const _WidgetDocumentos({super.key, required this.nomeDocumento});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(Assets.imagesIconePdf, color: Colors.green),
          Text(
            nomeDocumento.length > 20 ?
            "${nomeDocumento.substring(0,20)}..." : nomeDocumento,
            style: context.textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
