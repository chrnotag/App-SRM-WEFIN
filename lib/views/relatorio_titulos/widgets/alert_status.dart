part of '../relatorio_titulos_screen.dart';

class _AlertStatus extends StatefulWidget {
  const _AlertStatus({super.key});

  @override
  State<_AlertStatus> createState() => _AlertStatusState();
}

class _AlertStatusState extends State<_AlertStatus> {
  final provider = Modular.get<RelatorioTitulosProvider>();
  late bool VENCIDO;
  late bool A_VENCER;
  late bool LIQUIDADO;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VENCIDO = provider.VENCIDO;
    A_VENCER = provider.A_VENCER;
    LIQUIDADO = provider.LIQUIDADO;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Selecione o status:',
            style: context.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600, color: context.labelTextColor),
          ),
          SizedBox(
            height: 20.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntrinsicWidth(
                child: Row(
                  children: [
                    Checkbox(
                      value: VENCIDO,
                      onChanged: (value) => setState(() {
                        VENCIDO = !VENCIDO;
                        provider.VENCIDO = VENCIDO;
                      }),
                    ),
                    Text(
                      "Vencido",
                      style: VENCIDO
                          ? context.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: SRMColors.textBodyColor)
                          : context.textTheme.displayMedium!
                              .copyWith(color: context.labelTextColor),
                    ),
                  ],
                ),
              ),
              IntrinsicWidth(
                child: Row(
                  children: [
                    Checkbox(
                      value: A_VENCER,
                      onChanged: (value) => setState(() {
                        A_VENCER = !A_VENCER;
                        provider.A_VENCER = A_VENCER;
                      }),
                    ),
                    Text(
                      "A vencer",
                      style: A_VENCER
                          ? context.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: SRMColors.textBodyColor)
                          : context.textTheme.displayMedium!
                              .copyWith(color: context.labelTextColor),
                    ),
                  ],
                ),
              ),
              IntrinsicWidth(
                child: Row(
                  children: [
                    Checkbox(
                      value: LIQUIDADO,
                      onChanged: (value) => setState(() {
                        LIQUIDADO = !LIQUIDADO;
                        provider.LIQUIDADO = LIQUIDADO;
                      }),
                    ),
                    Text(
                      "Liquídado",
                      style: LIQUIDADO
                          ? context.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: SRMColors.textBodyColor)
                          : context.textTheme.displayMedium!
                              .copyWith(color: context.labelTextColor),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => Modular.to.pop(),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.r))),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: Text(
                'Cancelar',
                style: context.textTheme.bodyMedium!.copyWith(
                    color: context.primaryColor, fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            ElevatedButton(
              onPressed: () async {
                final params = RelatorioQueryParams(
                    dataFinalLiquidacao: null,
                    dataInicialLiquidacao: null,
                    dataFinalAVencer: null,
                    dataInicialAVencer: null,
                    statusRecebiveis: provider.listaStatus());
                OverlayApp.iniciaOverlay(context);
                await provider.recuperarTitulos(params);
                OverlayApp.terminaOverlay();
                Modular.to.pop();
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.r))),
                  backgroundColor: context.primaryColor),
              child: Text(
                'Confirmar',
                style:
                    context.textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
}
