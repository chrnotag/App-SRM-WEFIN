part of '../tela_extrato.dart';

class _ItemMenuFiltro extends StatefulWidget {
  final int quantidadeDias;
  final Map<String, Color> corSelecionado;
  const _ItemMenuFiltro({super.key, required this.quantidadeDias, required this.corSelecionado});

  @override
  State<_ItemMenuFiltro> createState() => _ItemMenuFiltroState();
}
class _ItemMenuFiltroState extends State<_ItemMenuFiltro> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 36.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
          border: Border.all(color: widget.corSelecionado['borda']!),
          color: widget.corSelecionado['fundo']),
      child: Center(
          child: Text(
        '${widget.quantidadeDias} dias',
        style: context.textTheme.bodyMedium!.copyWith(color: widget.corSelecionado['texto']),
      )),
    );
  }
}
