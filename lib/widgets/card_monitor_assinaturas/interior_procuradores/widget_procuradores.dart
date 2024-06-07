part of '../card_monitor_assinaturas.dart';

class _WidgetItemProcuradores extends StatelessWidget {
  final String? nomeProcurador;

  const _WidgetItemProcuradores({super.key, this.nomeProcurador});

  @override
  Widget build(BuildContext context) {
    return Text("$nomeProcurador");
  }
}
