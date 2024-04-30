part of '../tela_extrato.dart';

class _AppBarExtrato extends StatelessWidget {
  const _AppBarExtrato({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
      title: Text('Extrato'),
      centerTitle: true,
      actions: [
        IconButton(onPressed: (){}, icon: Image.asset(Assets.imagesIconePdf),)
      ],
      bottom: PreferredSize(preferredSize: TabBar(tabs: [],).preferredSize, child: _TabBarMeses()),
    );
  }
}
