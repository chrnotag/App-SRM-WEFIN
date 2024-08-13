import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/constants/enuns/tipo_operacao_enum.dart';
import '../../../../core/constants/route_labels.dart';

class ItemListaOperacao extends StatelessWidget {
  final TipoTED tipoTED;
  final String descricao;
  final double valorOperacao;
  final String codigoTransacao;
  final String dataComprovante;

  const ItemListaOperacao({
    super.key,
    required this.tipoTED,
    required this.descricao,
    required this.valorOperacao,
    required this.codigoTransacao,
    required this.dataComprovante,
  });

  @override
  Widget build(BuildContext context) {
    final temComprovante =
        !(tipoTED == TipoTED.DEVOLUCAO_TED || tipoTED == TipoTED.TARIFA_TED);
    return ListTile(
      onTap: temComprovante
          ? () {
              Modular.to.pushNamed(
                  AppRoutes.visualizarComprovanteTEDNavigatorRoute +
                      '/$codigoTransacao' +
                      '/$dataComprovante');
            }
          : () {
              Fluttertoast.showToast(
                  msg:
                      'Não há comprovante disponível para tarifas e/ou devoluções');
            },
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Image.asset(AssetsConfig.trustDollarListIcon),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tipoTED.stringTED),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: tipoTED.corFundo),
                          child: Text(
                            valorOperacao.toBRL,
                            style: context.textTheme.bodyMedium!
                                .copyWith(color: tipoTED.corTexto),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: temComprovante
                              ? Icon(
                                  Icons.attach_file,
                                  color: context.primaryColor,
                                )
                              : Padding(padding: EdgeInsets.only(left: 16.w)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.width * 0.75, child: Text(descricao)),
            ],
          )
        ],
      ),
    );
  }
}
