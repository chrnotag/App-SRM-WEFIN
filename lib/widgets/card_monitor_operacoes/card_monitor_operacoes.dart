import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/utils/money_format.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';
import '../component_card.dart';

class CardMonitorOperacoes extends StatefulWidget {
  final AssinaturasModel assinatura;

  const CardMonitorOperacoes({super.key, required this.assinatura});

  @override
  State<CardMonitorOperacoes> createState() => _CardMonitorOperacoesState();
}

class _CardMonitorOperacoesState extends State<CardMonitorOperacoes> {
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
                                  ComponentCardOperacoes(
                                      title: 'Operação',
                                      label:
                                          assinatura.codigoOperacao.toString()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ComponentCardOperacoes(
                                      title: 'Status',
                                      label: assinatura.statusOperacao,
                                      textStyle: context.textTheme.bodySmall)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ComponentCardOperacoes(
                                      title: 'Data',
                                      label: DateFormat("dd/MM/yyyy").format(
                                          DateTime.parse(
                                              assinatura.dataOperacao))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ComponentCardOperacoes(
                                    title: 'Valor Bruto',
                                    label: FormatarDinheiro.BR(double.parse(
                                        assinatura.valorBruto.toString())),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ComponentCardOperacoes(
                                      title: 'Produto',
                                      label: assinatura.siglaProduto),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ComponentCardOperacoes(
                                      title: 'Valor Liquido',
                                      label: FormatarDinheiro.BR(double.parse(
                                          assinatura.valorLiquido.toString()))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ver Assinaturas'),
                      ElevatedButton(
                          onPressed: () {}, child: Text('Assinaturas'))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 30,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }
}
