part of '../carteira_consolidada_screen.dart';

class _LegendaGraficoWidget extends StatelessWidget {
  final Color corLegenda;
  final String titulo;
  final String porcentagem;
  final double valor;
  final int qtdTitulos;

  const _LegendaGraficoWidget(
      {super.key,
      required this.corLegenda,
      required this.titulo,
      required this.porcentagem,
      required this.valor,
      required this.qtdTitulos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Ajuste essa altura conforme necessário
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 12.r,
                  backgroundColor: corLegenda,
                ),
                SizedBox(width: 8.0),
                Text(titulo)
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  porcentagem,
                  style: context.textTheme.displaySmall!.copyWith(
                    fontSize: 20.sp,
                      color: context.labelTextColor,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      FormatarDinheiro.BR(valor),
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: context.labelTextColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Text('$qtdTitulos Duplicatas', textAlign: TextAlign.end,),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
