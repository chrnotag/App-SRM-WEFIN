import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/models/operacoes_model/model_operacao.dart';

part 'component_card_operacoes.dart';
part 'expansible_card.dart';
part 'expansible_info_card.dart';

class CardMonitorOperacoes extends StatefulWidget {
  final bool showMoreInfo;
  final List<OperacaoModel>? operacaoModel;

  const CardMonitorOperacoes(
      {super.key, this.showMoreInfo = true, this.operacaoModel});

  @override
  State<CardMonitorOperacoes> createState() => _CardMonitorOperacoesState();
}

class _CardMonitorOperacoesState extends State<CardMonitorOperacoes> {
  bool _showInfo = false;

  @override
  Widget build(BuildContext context) {
    final generatedDate = faker.date.dateTime();
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
                                      title: 'Operações',
                                      label:
                                          '${faker.randomGenerator.integer(1000)}'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _ComponentCardOperacoes(
                                      title: 'Status',
                                      label: 'Aprovada',
                                      textStyle: context.textTheme.bodySmall!
                                          .copyWith(color: AppColors.laranja))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _ComponentCardOperacoes(
                                      title: 'Data',
                                      label:
                                          '${generatedDate.day.toString().padLeft(2, '0')}/'
                                          '${generatedDate.month.toString().padLeft(2, '0')}/'
                                          '${generatedDate.year}'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _ComponentCardOperacoes(
                                    title: 'Valor Bruto',
                                    label: _moneyFormater(double.parse(faker
                                        .randomGenerator
                                        .decimal(min: 10)
                                        .toString())),
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
                                      label: faker.food.cuisine()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _ComponentCardOperacoes(
                                      title: 'Valor Liquido',
                                      label: _moneyFormater(double.parse(faker
                                          .randomGenerator
                                          .decimal(min: 10)
                                          .toString()))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        decoration: const BoxDecoration(
                          color: AppColors.laranja,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSize(
                  duration: Duration(milliseconds: 500),
                  child: _ExpansibleInfoCard(
                    isVisible: _showInfo,
                    operacao: widget.operacaoModel!,
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
