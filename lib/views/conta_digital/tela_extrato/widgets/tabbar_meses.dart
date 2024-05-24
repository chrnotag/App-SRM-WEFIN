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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5))),
        margin: EdgeInsets.zero,
        elevation: 1,
        surfaceTintColor: Colors.white,
        child: TabBar(
          indicatorColor: SRMColors.secondaryColor,
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
              print('mes: $value');
              switch (value) {
                case 0:
                  setState(() {
                    extratoProvider.dataInicial =
                        CalcularUltimoDiaMes.resultado(DateTime(
                            DateTime.now().year, DateTime.now().month - 2));
                    print("data: ${extratoProvider.dataInicial}");
                    extratoProvider.carregarDados();
                  });
                  break;
                case 1:
                  setState(() {
                    extratoProvider.dataInicial =
                        CalcularUltimoDiaMes.resultado(DateTime(
                            DateTime.now().year, DateTime.now().month - 1));
                    print("data: ${extratoProvider.dataInicial}");
                    extratoProvider.carregarDados();
                  });
                  break;
                case 2:
                  setState(() {
                    extratoProvider.dataInicial = DateTime.now();
                    print("data: ${extratoProvider.dataInicial}");
                    extratoProvider.carregarDados();
                  });
                  break;
              }

              // extratoProvider.dataInicial = tabProvider.meses[value];
              // extratoProvider.carregarDados();
            });
          },
        ),
      ),
    );
  }
}
