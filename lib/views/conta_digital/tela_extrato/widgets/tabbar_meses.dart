part of '../tela_extrato.dart';

class _TabBarMeses extends StatefulWidget {
  final TabController controller;

  const _TabBarMeses({super.key, required this.controller});

  @override
  State<_TabBarMeses> createState() => _TabBarMesesState();
}

class _TabBarMesesState extends State<_TabBarMeses> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final extratoProvider = context.watch<ExtratoProvider>();
    final tabProvider = Modular.get<TabMesesProvider>();
    return SizedBox(
      width: context.width,
      height: 57.h,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero),
        margin: EdgeInsets.zero,
        elevation: 1,
        surfaceTintColor: Colors.white,
        child: TabBar(
          indicatorColor: context.secondaryColor,
          controller: widget.controller,
          tabs: Modular.get<TabMesesProvider>()
              .nomeDosMeses
              .map((meses) => Text(
                    meses,
                    style: context.textTheme.bodyLarge,
                  ))
              .toList(),
          dividerColor: Colors.transparent,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          onTap: (value) {
            setState(() {
              switch (value) {
                case 0:
                  setState(() {
                    extratoProvider.dataInicial =
                        CalcularUltimoDiaMes.resultado(DateTime(
                            DateTime.now().year, DateTime.now().month - 2));
                    extratoProvider.carregarDados();
                  });
                  break;
                case 1:
                  setState(() {
                    extratoProvider.dataInicial =
                        CalcularUltimoDiaMes.resultado(DateTime(
                            DateTime.now().year, DateTime.now().month - 1));
                    extratoProvider.carregarDados();
                  });
                  break;
                case 2:
                  setState(() {
                    extratoProvider.dataInicial = DateTime.now();
                    extratoProvider.carregarDados();
                  });
                  break;
              }
              extratoProvider.notificar();
              // extratoProvider.dataInicial = tabProvider.meses[value];
              // extratoProvider.carregarDados();
            });
          },
        ),
      ),
    );
  }
}
