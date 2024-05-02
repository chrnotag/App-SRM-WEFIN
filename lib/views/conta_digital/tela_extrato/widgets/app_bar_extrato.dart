part of '../tela_extrato.dart';

class _AppBarExtrato extends StatelessWidget {
  const _AppBarExtrato({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.azul,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
      title: Text('Extrato', style: context.textTheme.displaySmall!.copyWith(color: Colors.white),),
      centerTitle: true,
    );
  }
}
