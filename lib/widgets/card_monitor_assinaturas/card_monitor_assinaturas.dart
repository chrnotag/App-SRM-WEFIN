import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/iniciar_assinatura/iniciar_assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/certificado_provider.dart';
import 'package:Srm_Asset/core/utils/money_format.dart';
import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:Srm_Asset/widgets/card_monitor_assinaturas/fixed_card.dart';
import 'package:Srm_Asset/widgets/card_monitor_assinaturas/modal_documents.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import '../component_card.dart';
import 'expansible_card.dart';

part 'expansible_info_card.dart';

class CardMonitorAssinaturas extends StatefulWidget {
  final MonitorAssinaturasModel assinatura;
  final bool assinarDocumento;
  bool destacar;
  bool visualizarDocumento;

  CardMonitorAssinaturas(
      {super.key,
      required this.assinatura,
      this.assinarDocumento = false,
      this.destacar = false,
      this.visualizarDocumento = false});

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
              begin: TRUSTColors.primaryColor,
              end: TRUSTColors.primaryColor),
          weight: 99, // 50% da animação para aparecer
        ),
        TweenSequenceItem(
          tween: ColorTween(
              begin: TRUSTColors.primaryColor, end: Colors.transparent),
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
            color: _borderColor.value ?? Colors.transparent, width: 5.w),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        textStyle: context.textTheme.labelMedium!
                                            .copyWith(color: corAssinatura, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                ComponentCardOperacoes(title: 'Data', label: assinatura.dataOperacao, centralizar: true),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ComponentCardOperacoes(
                                        title: 'Produto',
                                        label: assinatura.siglaProduto,
                                    crossAxisAligment: CrossAxisAlignment.end,),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    ComponentCardOperacoes(
                                      title: 'Valor Bruto',
                                      crossAxisAligment: CrossAxisAlignment.end,
                                      label: FormatarDinheiro.BR(
                                          assinatura.valorBruto,),
                                    ),
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
                      codigoOperacao: assinatura.codigoOperacao,
                    ),
                  ),
                  widget.visualizarDocumento
                      ? FooterFixed(
                          onToggle: () {
                            showDialog(
                                context: context,
                                builder: (context) => ModalListDocumento(
                                      assinantes: widget.assinatura.assinantes,
                                      codigoOperacao:
                                          widget.assinatura.codigoOperacao,
                                    ));

                            setState(() {
                              assinaturaProvider.assinaturaSelecionada =
                                  assinatura;
                            });
                          },
                        )
                      : FooterExpansible(
                          showInfo: _showInfo,
                          onToggle: () {
                            setState(() {
                              assinaturaProvider.assinaturaSelecionada =
                                  assinatura;
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
