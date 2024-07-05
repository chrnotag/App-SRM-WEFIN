part of '../tela_extrato.dart';

class _MenuFiltroTelaExtrato extends StatefulWidget {
  const _MenuFiltroTelaExtrato({super.key});

  @override
  State<_MenuFiltroTelaExtrato> createState() => _MenuFiltroTelaExtratoState();
}

class _MenuFiltroTelaExtratoState extends State<_MenuFiltroTelaExtrato> {
  int filtroSelecionado = 7;
  Map<String, Color> corSelecionado(int indicie) {
    if(filtroSelecionado == indicie){
      return {
        'borda': context.secondaryColor,
        'fundo': context.secondaryColor,
        'texto': Colors.white,
      };
    }else{
      return {
        'borda': context.secondaryColor,
        'fundo': Colors.white,
        'texto': context.secondaryColor
      };
    }
  }

 final int MES = 30;
 final int QUINZENA = 15;
 final int SEMANA = 7;

  @override
  Widget build(BuildContext context) {
    final extratoProvider = context.watch<ExtratoProvider>();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 13.w),
            child: Text(
              'Movimentações',
              style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w900, color: Color(0XFF696969)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                radius: 12.r,
                child: _ItemMenuFiltro(quantidadeDias: SEMANA, corSelecionado: corSelecionado(SEMANA),),
                onTap: () => setState(() {
                  tamanhoLista = SEMANA;
                  extratoProvider.intervaloDias = SEMANA;
                  filtroSelecionado = SEMANA;
                  extratoProvider.carregarDados();
                }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: InkWell(
                  radius: 12.r,
                  child: _ItemMenuFiltro(quantidadeDias: QUINZENA, corSelecionado: corSelecionado(QUINZENA),),
                  onTap: () => setState(() {
                    tamanhoLista = QUINZENA;
                    extratoProvider.intervaloDias = QUINZENA;
                    filtroSelecionado = QUINZENA;
                    extratoProvider.carregarDados();
                  }),
                ),
              ),
              InkWell(
                radius: 12.r,
                child: _ItemMenuFiltro(quantidadeDias: MES,corSelecionado: corSelecionado(MES),),
                onTap: () => setState(() {
                  tamanhoLista = MES;
                  extratoProvider.intervaloDias = MES;
                  filtroSelecionado = MES;
                  extratoProvider.carregarDados();
                }),
              ),
              IconButton(
                onPressed: () =>
                    Modular.to.pushNamed(AppRoutes.selecionarDataScreenRoute),
                icon: Icon(
                  Icons.calendar_month,
                  size: 45.r,
                ),
                color: context.secondaryColor,
              ),
              InkWell(
                radius: 100.r,
                onTap: (){
                  Modular.to.pushNamed(AppRoutes.visualizarPdfScreenRoute);
                  extratoProvider.baixarDados();
                },
                child: Image.asset(
                  AssetsConfig.imagesIconePdf,
                  color: context.secondaryColor,
                  scale: 0.9,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
