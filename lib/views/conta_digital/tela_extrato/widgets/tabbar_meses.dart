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
    return SizedBox(
      width: context.width,
      height: 57.h,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
        margin: EdgeInsets.zero,
        elevation: 1,
        surfaceTintColor: Colors.white,
        child: TabBar(
          indicatorColor: AppColors.azul,
          controller: widget.controller,
          tabs: Modular
              .get<TabMesesProvider>()
              .meses
              .map((meses) => Text(meses, style: context.textTheme.bodyLarge,))
              .toList(),
          dividerColor: Colors.transparent,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
        ),
      ),
    );
  }
}
