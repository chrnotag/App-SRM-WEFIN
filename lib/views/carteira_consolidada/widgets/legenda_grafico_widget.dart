import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/money_format.dart';

class LegendaGraficoWidget extends StatelessWidget {
  final Color corLegenda;
  final String titulo;
  final String porcentagem;
  final double valor;
  final int qtdTitulos;

  const LegendaGraficoWidget(
      {super.key,
      required this.corLegenda,
      required this.titulo,
      required this.porcentagem,
      required this.valor,
      required this.qtdTitulos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88.h,
      child: Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
          ),
        ),
      ),
    );
  }
}
