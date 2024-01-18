import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:modular_study/core/constants/extensions/size_screen_extensions.dart';
import 'package:modular_study/core/constants/extensions/size_screen_media_query.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/iniciar_assinatura/iniciar_assinatura_provider.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificado_provider.dart';
import 'package:modular_study/core/utils/money_format.dart';
import 'package:modular_study/core/utils/valor_liquido.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';
import '../../core/constants/themes/theme_configs.dart';
import '../component_card.dart';
import 'expansible_card.dart';

part 'expansible_info_card.dart';

class CardMonitorAssinaturas extends StatefulWidget {
  final MonitorAssinaturasModel assinatura;
  final bool assinarDocumento;
  bool destacar;

  CardMonitorAssinaturas(
      {super.key,
      required this.assinatura,
      this.assinarDocumento = false,
      this.destacar = false});

  @override
  State<CardMonitorAssinaturas> createState() => _CardMonitorAssinaturasState();
}

class _CardMonitorAssinaturasState extends State<CardMonitorAssinaturas>
    with SingleTickerProviderStateMixin {
  bool _showInfo = false;

  late AnimationController _controller;
  late Animation<Color?> _borderColor;
  final AssinaturaProvider assinaturaProvider =
      Modular.get<AssinaturaProvider>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _borderColor = AlwaysStoppedAnimation<Color?>(Colors.transparent);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animarBorda();
    });
  }

  void _animarBorda() {
    if (widget.destacar) {
      _borderColor = TweenSequence<Color?>([
        TweenSequenceItem(
          tween: ColorTween(
              begin: AppColors.verdePrimarioTRUST,
              end: AppColors.verdePrimarioTRUST),
          weight: 99, // 50% da animação para aparecer
        ),
        TweenSequenceItem(
          tween: ColorTween(
              begin: AppColors.verdePrimarioTRUST, end: Colors.transparent),
          weight: 1, // 50% da animação para desaparecer
        ),
      ]).animate(_controller)
        ..addListener(() {
          setState(() {
            assinaturaProvider.isDestacado = true;
          });
        });
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant CardMonitorAssinaturas oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.destacar != oldWidget.destacar) {
      _animarBorda();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assinatura = widget.assinatura;
    final AssinaturaProvider assinaturaProvider =
        context.watch<AssinaturaProvider>();
    final Color corAssinatura = assinaturaProvider
        .definirCorStatusAssinatura(assinatura.statusAssinaturaDigital);
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        border: Border.all(
            color: _borderColor.value ?? Colors.transparent, width: 5),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        // Restante da decoração do seu card
      ),
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
                                        label: assinatura.codigoOperacao
                                            .toString()),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    ComponentCardOperacoes(
                                        title: 'Status',
                                        label:
                                            assinatura.statusAssinaturaDigital,
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
                                        label: ValorLiquido
                                            .regraExibirValorLiquido(
                                                statusOperacao:
                                                    assinatura.statusOperacao,
                                                valor:
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
                      codOperacao: assinatura.codigoOperacao,
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
      ),
    );
  }
}
