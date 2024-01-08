import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modular_study/core/constants/extensions/size_screen_extensions.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/utils/money_format.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import '../component_card.dart';

class CardMonitorOperacoes extends StatefulWidget {
  final MonitorAssinaturasModel assinatura;

  const CardMonitorOperacoes({super.key, required this.assinatura});

  @override
  State<CardMonitorOperacoes> createState() => _CardMonitorOperacoesState();
}

class _CardMonitorOperacoesState extends State<CardMonitorOperacoes> {
  @override
  Widget build(BuildContext context) {
    final assinatura = widget.assinatura;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
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
                          padding: EdgeInsets.all(8.r),
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
                                  SizedBox(
                                    height: 10.h,
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
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ComponentCardOperacoes(
                                    title: 'Valor Bruto',
                                    label: FormatarDinheiro.BR(
                                        assinatura.valorBruto),
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
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ComponentCardOperacoes(
                                      title: 'Valor Liquido',
                                      label: FormatarDinheiro.BR(
                                          assinatura.valorLiquido)),
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
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
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
            width: 30.w,
            height: 180.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.r),
                  bottomRight: Radius.circular(5.r)),
            ),
          ),
        ],
      ),
    );
  }
}
