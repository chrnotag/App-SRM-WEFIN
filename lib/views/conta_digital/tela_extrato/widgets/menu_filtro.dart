part of '../tela_extrato.dart';

class _MenuFiltroTelaExtrato extends StatefulWidget {
  const _MenuFiltroTelaExtrato({super.key});

  @override
  State<_MenuFiltroTelaExtrato> createState() => _MenuFiltroTelaExtratoState();
}

class _MenuFiltroTelaExtratoState extends State<_MenuFiltroTelaExtrato> {
  int filtroSelecionado = 7;

  Map<String, Color> corSelecionado(int indicie) {
    if (filtroSelecionado == indicie) {
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

  final int MES = 30;
  final int QUINZENA = 15;
  final int SEMANA = 7;

  final dadosBanco = Modular.get<ContaDigitalProvider>().dadosContaDigital;

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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: Color(0xffF5F6F8),
            ),
            margin: EdgeInsets.all(10.r),
            child: Padding(
              padding: EdgeInsets.all(10.r),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Banco: ',
                        style: context.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        '${dadosBanco!.codigo} - ${dadosBanco!.nome}',
                        style: context.textTheme.bodyLarge,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text('Agência: ',
                          style: context.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w900)),
                      Text(
                        dadosBanco!.agencia,
                        style: context.textTheme.bodyLarge,
                      ),
                      SizedBox(width: 10.w,),
                      Text('CC: ',
                          style: context.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w900)),
                      Text(
                        dadosBanco!.conta,
                        style: context.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('CNPJ: ',
                          style: context.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w900)),
                      Text('${dadosBanco!.documentoTitular.formatarDocumento()}', style: context.textTheme.bodyLarge,)
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                radius: 12.r,
                child: _ItemMenuFiltro(
                  quantidadeDias: SEMANA,
                  corSelecionado: corSelecionado(SEMANA),
                ),
                onTap: () => setState(() {
                  tamanhoLista = SEMANA;
                  extratoProvider.intervaloDias = SEMANA;
                  filtroSelecionado = SEMANA;
                  extratoProvider.carregarDados();
                  extratoProvider.notificar();
                }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: InkWell(
                  radius: 12.r,
                  child: _ItemMenuFiltro(
                    quantidadeDias: QUINZENA,
                    corSelecionado: corSelecionado(QUINZENA),
                  ),
                  onTap: () => setState(() {
                    tamanhoLista = QUINZENA;
                    extratoProvider.intervaloDias = QUINZENA;
                    filtroSelecionado = QUINZENA;
                    extratoProvider.carregarDados();
                    extratoProvider.notificar();
                  }),
                ),
              ),
              InkWell(
                radius: 12.r,
                child: _ItemMenuFiltro(
                  quantidadeDias: MES,
                  corSelecionado: corSelecionado(MES),
                ),
                onTap: () => setState(() {
                  tamanhoLista = MES;
                  extratoProvider.intervaloDias = MES;
                  filtroSelecionado = MES;
                  extratoProvider.carregarDados();
                  extratoProvider.notificar();
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
                onTap: () {
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
