import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificadode.dart';
import 'package:modular_study/core/utils/cor_operacao.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';
import 'package:modular_study/views/home/assinaturas/selecionar_certificado.dart';

import '../component_card.dart';
import 'expansible_card.dart';

part 'expansible_info_card.dart';

class CardMonitorAssinaturas extends StatefulWidget {
  final AssinaturasModel assinatura;
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
                                      textStyle: context.textTheme.bodySmall!
                                          .copyWith(
                                              color: CorOperacao
                                                  .definirCorOperacao(
                                                      assinatura)))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ComponentCardOperacoes(
                                      title: 'Data',
                                      label: assinatura.dataOperacao
                                          .replaceAll("-", "/")),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ComponentCardOperacoes(
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
                                  ComponentCardOperacoes(
                                      title: 'Produto',
                                      label: assinatura.siglaProduto),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ComponentCardOperacoes(
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

  _moneyFormater(double money) {
    return NumberFormat.currency(
            locale: 'pt-BR', symbol: 'R\$', decimalDigits: 2)
        .format(money);
  }
}
