part of '../relatorio_titulos_screen.dart';

class _MenuFiltro extends StatefulWidget {
  const _MenuFiltro({super.key});

  @override
  State<_MenuFiltro> createState() => _MenuFiltroState();
}

class _MenuFiltroState extends State<_MenuFiltro> {
  int menuSelecionado = 0;

  int MENU_LIQUIDACAO = 2;
  int MENU_VENCIMENTO = 1;
  int MENU_STATUS = 0;

  Map<String, Color> corItemMenu(int index) {
    if (index == menuSelecionado) {
      return {
        'borda': context.secondaryColor,
        'fundo': context.secondaryColor,
        'texto': Colors.white,
      };
    } else {
      return {
        'borda': context.secondaryColor,
        'fundo': Colors.white,
        'texto': context.secondaryColor
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(onTap: () => setState(() {
      menuSelecionado = MENU_LIQUIDACAO;
    }),child: _ItemMenuFiltro(corSelecionado: corItemMenu(MENU_LIQUIDACAO), textoMenu: 'Liquidação')),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: InkWell(onTap: () => setState(() {
    menuSelecionado = MENU_VENCIMENTO;
    }),child: _ItemMenuFiltro(corSelecionado: corItemMenu(MENU_VENCIMENTO), textoMenu: 'Vencimento')),
        ),
        InkWell(onTap: () => setState(() {
          menuSelecionado = MENU_STATUS;
        }),child: _ItemMenuFiltro(corSelecionado: corItemMenu(MENU_STATUS), textoMenu: 'Status')),
      ],
    );
  }
}
