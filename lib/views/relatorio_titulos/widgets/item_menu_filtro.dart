part of '../relatorio_titulos_screen.dart';

class _ItemMenuFiltro extends StatelessWidget {
  final Map<String, Color> corSelecionado;
  final String textoMenu;
  const _ItemMenuFiltro({super.key, required this.corSelecionado, required this.textoMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          border: Border.all(color: corSelecionado['borda']!),
          color: corSelecionado['fundo']),
      child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
            child: Text(
              textoMenu,
              style: context.textTheme.bodyMedium!.copyWith(color: corSelecionado['texto'], fontWeight: FontWeight.w900),
            ),
          )),
    );
  }
}
