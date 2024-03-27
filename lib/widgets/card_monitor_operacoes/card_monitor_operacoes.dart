import 'package:Srm_Asset/core/constants/themes/theme_configs.dart';
import 'package:Srm_Asset/core/utils/mostrar_botao_ver_assinatura.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/monitor_operacao_provider/monitor_operacoes_provider.dart';
import 'package:Srm_Asset/core/utils/money_format.dart';
import 'package:Srm_Asset/core/utils/valor_liquido.dart';
import 'package:Srm_Asset/models/monitor_operacoes_model/monitor_operacoes_model.dart';
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
    return SizedBox(
      height: ExibirVerAssinatura.isVisivel(operacao) ? 211.h : 142.h,
      child: Card(
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
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    crossAxisAligment: CrossAxisAlignment.end,
                                      title: 'Produto',
                                      label: operacao.siglaProduto),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ComponentCardOperacoes(
                                    crossAxisAligment: CrossAxisAlignment.end,
                                    title: 'Valor Bruto',
                                    label: FormatarDinheiro.BR(
                                        operacao.valorBruto),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: ExibirVerAssinatura.isVisivel(operacao),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        children: [
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Assinaturas Pendentes',
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: AppColors.vermelho,
                                    fontWeight: FontWeight.w300),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: context.focusColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.r)))),
                                  onPressed: () {
                                    final MonitorOperacoesProvider
                                        operacaoProvider =
                                        Modular.get<MonitorOperacoesProvider>();
                                    final AssinaturaProvider
                                        assinaturaProvider =
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
                                          'assinaturas': assinaturaProvider
                                              .todasAssinaturas,
                                          'assinaturasPendentes':
                                              assinaturasPendentes,
                                          'tab': 1,
                                          'destacar': true,
                                        });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(4.r),
                                    child: Text(
                                      'VER ASSINATURAS',
                                      style: context.textTheme.labelMedium!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
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
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: operacaoProvider
                    .corOperacao[operacao.statusOperacao.toUpperCase().trim()],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5.r),
                    bottomRight: Radius.circular(5.r)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
