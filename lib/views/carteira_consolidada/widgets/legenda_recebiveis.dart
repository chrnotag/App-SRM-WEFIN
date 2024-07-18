import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LegendaGraficoRecebiveisWidget extends StatelessWidget {
  final Color corLegenda;
  final String titulo;
  final String porcentagem;
  final double? valor;

  const LegendaGraficoRecebiveisWidget({
    super.key,
    required this.corLegenda,
    required this.titulo,
    required this.porcentagem,
     this.valor = 0,
  });

  @override
  Widget build(BuildContext context) {
    String formatarTitulo() {
      return titulo.length >= 25 ? "${titulo.substring(0, 25)}..." : titulo;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12.r,
                backgroundColor: corLegenda,
              ),
              SizedBox(width: 8.0),
              Text(formatarTitulo())
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (valor ?? 0).toBRL,
                style: context.textTheme.bodyMedium!.copyWith(
                    color: context.labelTextColor, fontWeight: FontWeight.w600),
              ),
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
    );
  }
}
