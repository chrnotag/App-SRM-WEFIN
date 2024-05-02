part of '../tela_extrato.dart';

class _ItemMenuFiltro extends StatefulWidget {
  final int quantidadeDias;
  const _ItemMenuFiltro({super.key, required this.quantidadeDias});

  @override
  State<_ItemMenuFiltro> createState() => _ItemMenuFiltroState();
}

class _ItemMenuFiltroState extends State<_ItemMenuFiltro> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 87.w,
      height: 36.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
          border: Border.all(color: Colors.black)
      ),
      child: Center(child: Text('${widget.quantidadeDias} dias', style: context.textTheme.bodyMedium,)),
    );
  }
}
