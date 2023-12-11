import 'dart:developer';

import 'package:crosspki/crosspki.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificadode.dart';
import 'package:modular_study/core/utils/cor_operacao.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';
import 'package:modular_study/views/home/assinaturas/selecionar_certificado.dart';

part 'component_card_operacoes.dart';
part 'expansible_card.dart';
part 'expansible_info_card.dart';

class CardMonitorOperacoes extends StatefulWidget {
  final bool showMoreInfo;
  final AssinaturasModel assinatura;

  const CardMonitorOperacoes(
      {super.key, this.showMoreInfo = true, required this.assinatura});

  @override
  State<CardMonitorOperacoes> createState() => _CardMonitorOperacoesState();
}

class _CardMonitorOperacoesState extends State<CardMonitorOperacoes> {
  bool _showInfo = false;

  @override
  Widget build(BuildContext context) {
    final assinatura = widget.assinatura;
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _ComponentCardOperacoes(
                                      title: 'Operação',
                                      label:
                                          assinatura.codigoOperacao.toString()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _ComponentCardOperacoes(
                                      title: 'Status',
                                      label: assinatura.statusOperacao,
                                      textStyle: context.textTheme.bodySmall!
                                          .copyWith(
                                              color: CorOperacao.definirCorOperacao(assinatura)))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _ComponentCardOperacoes(
                                      title: 'Data',
                                      label: assinatura.dataOperacao.replaceAll("-", "/")),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _ComponentCardOperacoes(
                                    title: 'Valor Bruto',
                                    label: _moneyFormater(double.parse(
                                        assinatura.valorBruto.toString())),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _ComponentCardOperacoes(
                                      title: 'Produto',
                                      label: assinatura.siglaProduto),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _ComponentCardOperacoes(
                                      title: 'Valor Liquido',
                                      label: _moneyFormater(double.parse(
                                          assinatura.valorLiquido.toString()))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        decoration: BoxDecoration(
                          color: CorOperacao.definirCorOperacao(assinatura),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  child: _ExpansibleInfoCard(
                    isVisible: _showInfo,
                    assinantes: assinatura.assinantes,
                  ),
                ),
                _FooterExpansible(
                  isExpansible: widget.showMoreInfo,
                  onToggle: () {
                    setState(() {
                      _showInfo = !_showInfo;
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  _moneyFormater(double money) {
    return NumberFormat.currency(
            locale: 'pt-BR', symbol: 'R\$', decimalDigits: 2)
        .format(money);
  }
}
