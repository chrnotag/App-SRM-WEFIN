part of '../card_monitor_assinaturas.dart';

class _ItemListaDocumentos extends StatelessWidget {
  final String titulo;
  final List<Widget> conteudo;
  const _ItemListaDocumentos({super.key, required this.titulo, required this.conteudo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            titulo,
            style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, color: Color(0XFF838383)),
          ),
        ),
        ...conteudo
      ],
    );
  }
}