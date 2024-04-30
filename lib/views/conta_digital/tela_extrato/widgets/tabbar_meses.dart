part of '../tela_extrato.dart';

class _TabBarMeses extends StatefulWidget {
  const _TabBarMeses({super.key});

  @override
  State<_TabBarMeses> createState() => _TabBarMesesState();
}

class _TabBarMesesState extends State<_TabBarMeses> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
        children: Modular.get<TabMesesProvider>().meses.map((meses) {
      return Center(child: Text(meses));
    }).toList());
  }
}
