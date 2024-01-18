import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:modular_study/core/constants/extensions/size_screen_extensions.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/providers/monitor_operacao_provider/monitor_operacoes_provider.dart';
import 'package:modular_study/core/utils/money_format.dart';
import 'package:modular_study/models/monitor_operacoes_model/monitor_operacoes_model.dart';
import '../../core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import '../../models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import '../component_card.dart';

class CardMonitorOperacoes extends StatefulWidget {
  final MonitorOperacoesModel operacoes;

  const CardMonitorOperacoes({super.key, required this.operacoes});

  @override
  State<CardMonitorOperacoes> createState() => _CardMonitorOperacoesState();
}

class _CardMonitorOperacoesState extends State<CardMonitorOperacoes> {
  @override
  Widget build(BuildContext context) {
    final operacao = widget.operacoes;
    final MonitorOperacoesProvider operacaoProvider =
        Modular.get<MonitorOperacoesProvider>();
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
                                          operacao.codigoOperacao.toString()),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ComponentCardOperacoes(
                                      title: 'Status',
                                      label: operacao.statusOperacao,
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
                                              operacao.dataOperacao))),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ComponentCardOperacoes(
                                    title: 'Valor Bruto',
                                    label: FormatarDinheiro.BR(
                                        operacao.valorBruto),
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
                                      label: operacao.siglaProduto),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ComponentCardOperacoes(
                                      title: 'Valor Liquido',
                                      label: operacaoProvider
                                          .regraExibirValorLiquido(operacao)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isVisivel(operacao),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      children: [
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Ver Assinaturas'),
                            ElevatedButton(
                                onPressed: () {
                                  final MonitorOperacoesProvider
                                      operacaoProvider =
                                      Modular.get<MonitorOperacoesProvider>();
                                  final AssinaturaProvider assinaturaProvider =
                                      Modular.get<AssinaturaProvider>();
                                  List<MonitorAssinaturasModel>
                                      assinaturasPendentes =
                                      assinaturaProvider.assinaturasPendentes;
                                  operacaoProvider.aconragemAssinatura(
                                      assinaturaProvider.todasAssinaturas,
                                      operacao.codigoOperacao);
                                  Modular.to.pushNamed(
                                      AppRoutes.assinaturaDigitalRoute,
                                      arguments: {
                                        'assinaturas':
                                            assinaturaProvider.todasAssinaturas,
                                        'assinaturasPendentes':
                                            assinaturasPendentes,
                                        'tab': 1,
                                        'destacar': true,
                                      });
                                },
                                child: Text(
                                  'Assinaturas',
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(color: Colors.white),
                                ))
                          ],
                        ),
                      ],
                    ),
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

  bool isVisivel(MonitorOperacoesModel operacao) {
    AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
    final mapaAssinaturas = assinaturaProvider.assinaturasMapeadas;
    if (mapaAssinaturas.containsKey(operacao.codigoOperacao)) {
      var assinatura = mapaAssinaturas[operacao.codigoOperacao];
      if ((operacao.statusOperacao.trim() == 'Aguardando Assinatura' ||
              operacao.statusOperacao.trim() == 'Assinada') &&
          (assinatura?.statusAssinaturaDigital == 'Assinada' ||
              assinatura?.statusAssinaturaDigital == 'Aguardando Assinatura')) {
        return true;
      }
    }
    return false;
  }
}
