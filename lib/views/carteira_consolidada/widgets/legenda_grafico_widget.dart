import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LegendaGraficoWidget extends StatelessWidget {
  final Color corLegenda;
  final String titulo;
  final String porcentagem;
  final double? valor;
  final int qtdTitulos;

  const LegendaGraficoWidget(
      {super.key,
      required this.corLegenda,
      required this.titulo,
      required this.porcentagem,
      this.valor = 0,
      required this.qtdTitulos});

  @override
  Widget build(BuildContext context) {
    print('itens: $titulo $valor');
    return SizedBox(
      height: 85.h,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 12.r,
                  backgroundColor: valor == null && valor == 0 ? corLegenda : context.labelTextColor,
                ),
                SizedBox(width: 8.0),
                Expanded(child: Text(titulo, maxLines: 1, overflow: TextOverflow.ellipsis,))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Text(
                    porcentagem,
                    style: context.textTheme.displaySmall!.copyWith(
                        fontSize: 20.sp,
                        color: context.labelTextColor,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      (valor ?? 0).toBRL,
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: context.labelTextColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '$qtdTitulos Duplicatas',
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
