import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:modular_study/core/constants/extensions/size_screen_extensions.dart';
import 'package:modular_study/core/constants/extensions/size_screen_media_query.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificadode.dart';
import 'package:modular_study/core/utils/money_format.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';
import '../component_card.dart';
import 'expansible_card.dart';

part 'expansible_info_card.dart';

class CardMonitorAssinaturas extends StatefulWidget {
  final MonitorAssinaturasModel assinatura;
  final bool assinarDocumento;

  const CardMonitorAssinaturas(
      {super.key, required this.assinatura, this.assinarDocumento = false});

  @override
  State<CardMonitorAssinaturas> createState() => _CardMonitorAssinaturasState();
}

class _CardMonitorAssinaturasState extends State<CardMonitorAssinaturas> {
  bool _showInfo = false;

  @override
  Widget build(BuildContext context) {
    final assinatura = widget.assinatura;
    final AssinaturaProvider assinaturaProvider =
        context.watch<AssinaturaProvider>();
    final String statusAssinatura =
        assinaturaProvider.traduzirStatusAssinaturas(assinatura);
    final Color corAssinatura =
        assinaturaProvider.definirCorStatusAssinatura(statusAssinatura);
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
                                      label: statusAssinatura,
                                      textStyle: context.textTheme.bodySmall!
                                          .copyWith(color: corAssinatura)),
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
                      Container(
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: corAssinatura,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  child: _ExpansibleInfoCard(
                    assinarDocumento: widget.assinarDocumento,
                    isVisible: _showInfo,
                    assinantes: assinatura.assinantes,
                  ),
                ),
                FooterExpansible(
                  onToggle: () {
                    setState(() {
                      assinaturaProvider.assinaturaSelecionada = assinatura;
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
}
